"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open terminal (docked)
nnoremap <silent> <leader>] :bo term ++rows=16<CR>

" open terminal (vertical split)
nnoremap <silent> <leader>[ :vert bo term<CR>

" auto configure terminal statusline
augroup terminal_mapping
	autocmd!
	autocmd TerminalWinOpen * setlocal statusline=%#SignColumn# nolist nonumber nobuflisted
augroup END

