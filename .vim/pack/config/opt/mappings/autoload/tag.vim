"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Improved Tag Navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Push to the tag stack.
function! s:tag_stack_push(tagname, matchnr) abort
	try
		execute a:matchnr . 'tag ' . a:tagname
	catch
		echohl ErrorMsg | echo 'tag not found: ' . a:tagname | echohl None
	endtry
endfunction

" The semantics of this was pulled from the vim source for the :tselect/:tjump
" commands.
function! s:context_from_tag(cmd) abort
	" remove '/', '/' and '?^'
	let l:result = substitute(a:cmd, '\(/^\?\)\|\(?^\)', '', '')

	" remove leading whitespace
	let l:result = trim(l:result)

	" remove backslash escapes (best effort)
	let l:result = substitute(l:result, '\\\([^\\]\)\@=', '', 'g')

	" truncate whitespace
	let l:result = substitute(l:result, '\s\+', ' ', 'g')

	" dont display the '$/;\"' and '$?;\"'
	let l:result = substitute(l:result, '\$[/;]*$', '', 'g')

	" truncate if long
	let l:result = len(l:result) >= 60 ? (l:result[0:57] . '...') : l:result

	return l:result
endfunction

" Build a new popup entry table. Used to space text content into aligned
" columns with text properties.
function! s:entry_table_new() abort
	return { 'rows': [], 'col_widths': [] }
endfunction

" Add a single row to the entry table. Each entry in `columns` is a a list of
" 1 or two items:
"   [<text>], or
"   [<text>, <prop name>]
function! s:entry_table_add_row(table, columns) abort
	let l:row = []
	for index in range(len(a:columns))
		let l:column = a:columns[index]

		let l:text = get(l:column, 0, '')
		let l:prop = get(l:column, 1, v:null)
		let l:col_data = extend({ 'text': l:text },
			\ l:prop != v:null ? { 'prop': l:prop } : {})

		call add(l:row, l:col_data)

		" adjust column width
		if index >= len(a:table['col_widths'])
			call add(a:table['col_widths'], len(l:text))
		else
			let a:table['col_widths'][index] = max([a:table['col_widths'][index], len(l:text)])
		endif
	endfor

	call add(a:table['rows'], l:row)
endfunction

" Build a list of popup entries (that can be passed to popup_settext()) from
" an entry table.
function! s:entry_table_build(table) abort
	let l:rows = a:table['rows']
	let l:col_widths = a:table['col_widths']

	let l:results = []
	for index in range(len(l:rows))
		let l:columns = l:rows[index]

		let l:text = ''
		let l:props = []
		for col_idx in range(len(l:columns))
			let l:column = l:columns[col_idx]
			let l:col_text = l:column['text']
			let l:col_width = l:col_widths[col_idx]

			if has_key(l:column, 'prop')
				call add(l:props, {
					\ 'col': len(l:text) + 1,
					\ 'length': len(l:col_text),
					\ 'type': l:column['prop']
				\ })
			endif

			let l:text .= l:col_text . repeat(' ', l:col_width - len(l:col_text))
		endfor

		call add(l:results, { 'text': l:text, 'props': l:props })
	endfor

	return l:results
endfunction

" Get the name of a text property for darker text. Adds the text property type
" if the property type does not yet exist.
function! s:get_text_prop_dark() abort
	let l:prop_name = 'tag-navigation-text-dark'

	if empty(prop_type_get(l:prop_name))
		call prop_type_add(l:prop_name, { 'highlight': 'PmenuTextDark' })
	endif

	return l:prop_name
endfunction

" Build a list of popup entries. The result is a list, where each entry is a
" list of popup entries with different information.
"     entry 1: tag information showing filename
"     entry 2: tag information showing context information (command)
function! s:build_popup_entries(tag_results) abort
	let l:dark_text_prop = s:get_text_prop_dark()

	let l:popup_entries_context = s:entry_table_new()
	let l:popup_entries_file = s:entry_table_new()

	for result in a:tag_results
		" build columns for context entries
		call s:entry_table_add_row(l:popup_entries_context, [
			\ [printf(' [%s] ', result['kind'] ?? '?'), l:dark_text_prop],
			\ [result['name']],
			\ [printf('  %s ', s:context_from_tag(result['cmd'])), l:dark_text_prop],
		\ ])

		" build columns for filename entries
		call s:entry_table_add_row(l:popup_entries_file, [
			\ [printf(' [%s] ', result['kind'] ?? '?'), l:dark_text_prop],
			\ [result['name']],
			\ [printf('  %s ', pathshorten(result['filename'])), l:dark_text_prop],
		\ ])
	endfor

	return [
		\ s:entry_table_build(l:popup_entries_context),
		\ s:entry_table_build(l:popup_entries_file),
	\ ]
endfunction

" A 'tagfunc' that simply performs a vimgrep in the current buffer when no
" tag files are available.
function! VimgrepCurrentBufferTagFunc(pattern, flags, info) abort
	call setqflist([])
	let l:buffers = getbufinfo({'buflisted': 1, 'windows': gettabinfo(tabpagenr())})
	for b in l:buffers
		try
			execute 'vimgrepadd /' . a:pattern . '/jg #' . b['bufnr']
		catch
		endtry
	endfor

	let l:search_results = getqflist()
	let l:results = []
	for result in l:search_results
		call add(l:results, {
			\ 'name': a:pattern,
			\ 'filename': expand('#' . result['bufnr'] . ':p'),
			\ 'cmd': '/^' . escape(result['text'], '/\') . '$/',
			\ 'kind': 'g'
		\ })
	endfor

	return l:results
endfunction

" Navigate to a tag with the given keyword, showing a popup with results if
" more than one match is found.
"
" If there are no tag files, a custom 'tagfunc' is used to offer results from
" buffers through a simple search.
function! tag#step_into(keyword) abort
	" save the tagfunc so that we can restore it later
	let l:save_tagfunc = &tagfunc
	if empty(tagfiles())
		let &l:tagfunc = 'VimgrepCurrentBufferTagFunc'
	endif

	let l:tag_results = taglist(a:keyword)
	if empty(l:tag_results)
		echohl ErrorMsg | echo 'tag not found: ' . a:keyword | echohl None
		return
	endif

	if len(l:tag_results) == 1
		" jump to that one tag result
		call s:tag_stack_push(l:tag_results[0]['name'], 1)
		return
	endif

	let l:popup_entries = s:build_popup_entries(l:tag_results)
	let l:state = 0

	" callback function when the popup is closed
	function! s:popup_menu_cb(id, result) abort closure
		if a:result <= 0
			return
		endif

		call s:tag_stack_push(l:tag_results[a:result - 1]['name'], a:result)

		" restore the tagfunc
		let &l:tagfunc = l:save_tagfunc
	endfunction

	" rotate the entries in the popup
	function! s:rotate_popup_entries(id, new_state) abort closure
		let l:state = a:new_state < 0 ? 1 : (a:new_state > 1 ? 0 : a:new_state)
		call popup_settext(a:id, l:popup_entries[l:state])
	endfunction

	" filter callback
	function! s:popup_menu_filter_cb(id, key) abort closure
		if a:key == 'l' || a:key == "\<Right>"
			call s:rotate_popup_entries(a:id, l:state + 1)
			return 1
		elseif a:key == 'h' || a:key == "\<Left>"
			call s:rotate_popup_entries(a:id, l:state - 1)
			return 1
		else
			return popup_filter_menu(a:id, a:key)
		endif
	endfunction

	call popup_create(l:popup_entries[l:state], {
		\ 'line': 'cursor+1',
		\ 'col': 'cursor',
		\ 'title': ' jump to definition "' . a:keyword . '"',
		\ 'wrap': v:false,
		\ 'moved': 'word',
		\ 'cursorline': 1,
		\ 'filter': function('s:popup_menu_filter_cb'),
		\ 'callback': function('s:popup_menu_cb')
	\ })
endfunction
