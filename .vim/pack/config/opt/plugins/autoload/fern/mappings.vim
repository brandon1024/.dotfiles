function! fern#mappings#init() abort
	nmap <buffer> h <Plug>(fern-action-open:split)
	nmap <buffer> v <Plug>(fern-action-open:vsplit)
	nmap <buffer> p <Plug>(fern-action-preview)
	nmap <buffer> <CR> <Plug>(fern-action-toggle-expand-open)

	nmap <buffer><expr> <Plug>(fern-action-toggle-expand-open)
		\ fern#smart#leaf(
		\   "<Plug>(fern-action-open:select)",
		\   "<Plug>(fern-action-expand)",
		\   "<Plug>(fern-action-collapse)")
endfunction
