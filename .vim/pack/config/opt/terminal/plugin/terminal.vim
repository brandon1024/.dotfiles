"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open terminal (docked)
nnoremap <silent> <leader>td :bo term ++rows=16<CR>

" open terminal (vertical split)
nnoremap <silent> <leader>tv :vert bo term<CR>

" auto configure terminal statusline
augroup terminal_mapping
	autocmd!
	autocmd TerminalWinOpen * setlocal statusline=%#SignColumn# nolist nonumber
augroup END

