function! ToggleQuickFixWindow()
	" find quickfix window in this tab
	let l:qf_win = filter(getwininfo(),
		\ { idx, val -> val['quickfix'] && val['tabnr'] == tabpagenr() })

	if len(l:qf_win)
		cclose
	else
		bo copen 16
	endif
endfunction

" [normal] open quickfix (docked)
nnoremap <silent> <leader>q :call ToggleQuickFixWindow()<CR>

" [norma] go to next/previous quickfix item
nnoremap <silent> <leader>- :cprev<CR>
nnoremap <silent> <leader>= :cnext<CR>
