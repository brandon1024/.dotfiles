"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open terminal (docked)
nnoremap <silent> <leader>] :bo term ++rows=16<CR>

" open terminal (vertical split)
nnoremap <silent> <leader>[ :vert bo term<CR>

" configure the terminal
function! s:TerminalConfiguration()
	setlocal statusline=%#SignColumn# nolist nonumber nobuflisted complete=.
	tnoremap <buffer> <C-W><PageUp> <C-W>N
endfunction

" auto configure terminal statusline and options
augroup terminal_autogroup
	autocmd!
	autocmd TerminalWinOpen * call s:TerminalConfiguration()
augroup END

