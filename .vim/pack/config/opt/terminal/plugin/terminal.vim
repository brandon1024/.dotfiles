"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" open terminal (docked)
nnoremap <silent> <leader>] :call <SID>TerminalToggle()<CR>

" open terminal (vertical split)
nnoremap <silent> <leader>[ :vert bo term<CR>

function! s:TerminalToggle()
	if !bufexists('docked-terminal')
		bo term ++rows=16<CR>
		silent file docked-terminal
		let s:term_winnr = winnr('$')
		let s:term_collapsed = v:false
	else
		exe s:term_winnr . 'resize ' . (s:term_collapsed ? '16' : '1')
		let s:term_collapsed = !s:term_collapsed
	endif
endfunction

" auto configure terminal statusline and options
augroup terminal_autogroup
	autocmd!
	autocmd TerminalWinOpen * setlocal statusline=%!ui#segment#Render(ui#terminal#BuildSegments())
	autocmd TerminalWinOpen * setlocal nolist nobuflisted complete=. winfixheight
augroup END

