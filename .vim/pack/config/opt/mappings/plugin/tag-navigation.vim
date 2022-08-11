function! s:PushToTagStack(tagname, matchnr) abort
	execute a:matchnr . 'tag ' . a:tagname
endfunction

" The semantics of this was pulled from the vim source for the :tselect/:tjump
" commands.
function! TagContextFromCommand(cmd) abort
	" remove '/^' and '?^'
	let l:result = substitute(a:cmd, '[/?]\^', '', '')

	" remove leading whitespace
	let l:result = trim(l:result)

	" remove backslash escapes (best effort)
	let l:result = substitute(l:result, '\\\([^\\]\)\@=', '', 'g')

	" truncate whitespace
	let l:result = substitute(l:result, '\s\+', ' ', 'g')

	" dont display the '$/;\"' and '$?;\"'
	let l:result = substitute(l:result, '\$[/;]*$', '', 'g')

	return l:result
endfunction

" Navigate to a tag with the given keyword, showing a popup with results if
" more than one match is found.
function! TagNavigationStepInto(keyword) abort
	if empty(tagfiles())
		echoerr 'no tags file'
		return
	endif

	let l:tag_results = taglist(a:keyword)
	if empty(l:tag_results)
		echoerr 'tag not found: ' . a:keyword
		return
	endif

	if len(l:tag_results) == 1
		" jump to that one tag result
		call s:PushToTagStack(l:tag_results[0]['name'], 1)
		return
	endif

	" popup entries organized as a tuple of lists:
	"     entry 1: tag information showing filename
	"     entry 2: tag information showing context information (command)
	let l:popup_entries = [[],[]]
	let l:state = 0
	for tag_result in l:tag_results
		let l:kind = tag_result['kind']
		let l:name = tag_result['name']
		let l:context = TagContextFromCommand(tag_result['cmd'])
		let l:fname = pathshorten(tag_result['filename'])

		call add(l:popup_entries[0],
			\ printf(' [%s] %s	%s ', l:kind, l:name, l:fname))
		call add(l:popup_entries[1],
			\ printf(' [%s] %s  	%s ', l:kind, l:name, l:context))
	endfor

	" callback function when the popup is closed
	function! s:PopupMenuCallback(id, result) abort closure
		if a:result <= 0
			return
		endif

		call s:PushToTagStack(l:tag_results[a:result - 1]['name'], a:result)
	endfunction

	" rotate the entries in the popup
	function! s:RotatePopupEntries(id, new_state) abort closure
		let l:state = a:new_state < 0 ? 1 : (a:new_state > 1 ? 0 : a:new_state)
		call popup_settext(a:id, l:popup_entries[l:state])
	endfunction

	" filter callback
	function! s:PopupMenuFilterCallback(id, key) abort closure
		if a:key == 'l' || a:key == "\<Right>"
			call s:RotatePopupEntries(a:id, l:state + 1)
			return 1
		elseif a:key == 'h' || a:key == "\<Left>"
			call s:RotatePopupEntries(a:id, l:state - 1)
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
		\ 'filter': function('s:PopupMenuFilterCallback'),
		\ 'callback': function('s:PopupMenuCallback')
	\ })
endfunction

" [normal] navigate to and from tag results
nnoremap <silent> <C-]> :call TagNavigationStepInto(expand('<cword>'))<CR>

