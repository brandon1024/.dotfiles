augroup window_autocmd_group
	autocmd!
	autocmd WinEnter * setlocal colorcolumn=+0
	autocmd WinLeave * setlocal colorcolumn=
	autocmd BufWinEnter * setlocal colorcolumn=+0
	autocmd BufWinLeave * setlocal colorcolumn=
augroup END

