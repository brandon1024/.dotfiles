function! fern#mappings#init() abort
	nmap <buffer> cd <Plug>(fern-action-enter)
	nmap <buffer> l <Plug>(fern-action-open-or-enter)
	nmap <buffer> h <Plug>(fern-action-open:split)
	nmap <buffer> v <Plug>(fern-action-open:vsplit)
	nmap <buffer> <CR> <Plug>(fern-action-toggle-expand-open)

	nmap <buffer><expr> <Plug>(fern-action-toggle-expand-open)
		\ fern#smart#leaf(
		\   "<Plug>(fern-action-open)",
		\   "<Plug>(fern-action-expand)",
		\   "<Plug>(fern-action-collapse)")
endfunction
