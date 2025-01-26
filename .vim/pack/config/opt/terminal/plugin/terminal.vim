"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal Configuration and Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" open terminal (docked, stacked or tabbed)
nnoremap <silent> <leader>] :call terminal#new_docked()<CR>
nnoremap <silent> <leader>} :call terminal#new_stacked()<CR>
nnoremap <silent> <leader>t :call terminal#new_tabbed()<CR>

" auto configure terminal statusline and options
augroup terminal_autogroup
	autocmd!
	autocmd TerminalWinOpen * setlocal nolist nobuflisted complete=. winfixheight nowrap statusline=%#Normal#
	autocmd TerminalOpen * call terminal#on_open()
augroup END

