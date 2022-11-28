function! java_support#mappings#init() abort
	nmap <silent> <buffer> <C-i> <Plug>(java-support-import:add)
	nmap <silent> <buffer> <F6> <Plug>(java-support-import:sort)
	nmap <silent> <buffer> <leader>jc <Plug>(java-support-index:dir)
	nnoremap <silent> <buffer> <F5> :Java insert-var<CR>
	inoremap <silent> <buffer> <F5> <C-o>:Java insert-var<CR>

	nmap <silent> <buffer> <C-_> gcc
	vmap <silent> <buffer> <C-_> gc
endfunction
