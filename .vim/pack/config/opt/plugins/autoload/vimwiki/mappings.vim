function! vimwiki#mappings#init() abort
	nnoremap <silent> <buffer> <CR> <Plug>VimwikiFollowLink
	nnoremap <silent> <buffer> <Backspace> <Plug>VimwikiGoBackLink
	nnoremap <silent> <buffer> <Space> <Plug>VimwikiToggleListItem
endfunction
