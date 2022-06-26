"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open terminal (docked)
nnoremap <silent> <leader>] :call TerminalToggle()<CR>

" open terminal (vertical split)
nnoremap <silent> <leader>[ :vert bo term<CR>

function! TerminalToggle()
	if !bufexists('docked-terminal')
		bo term ++rows=16<CR>
		silent file docked-terminal
		let s:term_winnr = winnr('$')
		let s:term_collapsed = v:false
	else
		exe s:term_winnr . 'resize ' . (s:term_collapsed ? '16' : '2')
		let s:term_collapsed = !s:term_collapsed
	endif
endfunction

" configure the terminal
function! s:TerminalConfiguration()
	setlocal statusline=%#SignColumn# nolist nobuflisted complete=. winfixheight
	tnoremap <buffer> <C-W><PageUp> <C-W>N<PageUp>
endfunction

" auto configure terminal statusline and options
augroup terminal_autogroup
	autocmd!
	autocmd TerminalWinOpen * call s:TerminalConfiguration()
augroup END

" run a command and show result in a terminal window
cabbrev ! bo term ++rows=16

