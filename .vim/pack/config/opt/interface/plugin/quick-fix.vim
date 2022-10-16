" auto configure quickfix window (set unlisted)
augroup quickfix_autogroup
	autocmd!
	autocmd BufReadPost quickfix setlocal nobuflisted
augroup END

