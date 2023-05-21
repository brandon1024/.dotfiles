"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal Configuration and Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" open terminal (docked)
nnoremap <silent> <leader>] :call terminal#new_docked()<CR>
nnoremap <silent> <leader>} :call terminal#new_stacked()<CR>

" auto configure terminal statusline and options
augroup terminal_autogroup
	autocmd!
	autocmd TerminalWinOpen * setlocal statusline=%!ui#segment#render(ui#terminal#build_segments())
	autocmd TerminalWinOpen * setlocal nolist nobuflisted complete=. winfixheight nowrap
augroup END

