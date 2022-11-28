"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Docked Terminal Management
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Open a new docked terminal.
"
" The new terminal will be opened below all existing windows and will occupy
" the full width of the terminal. If a terminal window is already open, a new
" docked window will be created beside the existing one.
function! terminal#new_docked() abort
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

