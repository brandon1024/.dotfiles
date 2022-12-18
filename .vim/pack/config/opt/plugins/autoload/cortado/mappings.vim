function! cortado#mappings#init() abort
	nmap <silent> <buffer> <C-i>      <Plug>(cortado-imports:add)
	nmap <silent> <buffer> <F6>       <Plug>(cortado-imports:sort)
	nmap <silent> <buffer> <leader>jc <Plug>(cortado-index:dir)
	nmap <silent> <buffer> <F5>       <Plug>(cortado-templates:var)
	imap <silent> <buffer> <F5>       <Plug>(cortado-templates:var)
endfunction
