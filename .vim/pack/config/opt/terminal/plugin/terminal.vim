"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" open terminal (docked)
nnoremap <silent> <leader>] :call <SID>TerminalNew()<CR>

function! s:TerminalNew() abort
	let l:term_wins = filter(getwininfo(),
		\ { idx, win -> win['terminal'] && win['tabnr'] == tabpagenr() })

	" find our (managed) terminal windows
	let l:term_wins = filter(l:term_wins,
		\ { idx, win -> has_key(win['variables'], '_managed_term') })

	if empty(l:term_wins)
		bo term ++rows=16<CR>
		let l:new_term_winnr = winnr('$')
		call setwinvar(l:new_term_winnr, '_managed_term', 1)
	else
		call win_gotoid(l:term_wins[-1]['winid'])
		vert new
		let l:new_term_winnr = winnr('$')
		call setwinvar(l:new_term_winnr, '_managed_term', 1)
		term ++curwin
	endif
endfunction

" auto configure terminal statusline and options
augroup terminal_autogroup
	autocmd!
	autocmd TerminalWinOpen * setlocal statusline=%!ui#segment#Render(ui#terminal#BuildSegments())
	autocmd TerminalWinOpen * setlocal nolist nobuflisted complete=. winfixheight
augroup END

