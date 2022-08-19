function! s:PushToTagStack(tagname, matchnr) abort
	execute a:matchnr . 'tag ' . a:tagname
endfunction

function! TagNavigationStepInto(keyword) abort
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

	function! s:PopupMenuCallback(id, result) abort closure
		if a:result <= 0
			return
		endif

		call s:PushToTagStack(l:tag_results[a:result - 1]['name'], a:result)
	endfunction

	let l:popup_entries = []
	for tag_result in l:tag_results
		let l:kind = tag_result['kind']
		let l:name = tag_result['name']
		let l:fname = pathshorten(tag_result['filename'])

		call add(l:popup_entries,
			\ printf(' [%s] %s	%s ', l:kind, l:name, l:fname))
	endfor

	call popup_create(l:popup_entries, {
		\ 'line': 'cursor+1',
		\ 'col': 'cursor',
		\ 'title': ' jump to definition "' . a:keyword . '"',
		\ 'wrap': v:false,
		\ 'moved': 'word',
		\ 'cursorline': 1,
		\ 'filter': function('popup_filter_menu'),
		\ 'callback': function('s:PopupMenuCallback')
	\ })
endfunction

" [normal] navigate to and from tag results
nnoremap <silent> <C-]> :call TagNavigationStepInto(expand('<cword>'))<CR>

