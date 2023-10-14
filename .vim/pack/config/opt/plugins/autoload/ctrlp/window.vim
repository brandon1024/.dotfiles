" Unset 't_ve' to remove cursor highlight for the ctrlp window.
function! ctrlp#window#enter() abort
	let s:t_ve_saved = &t_ve
	set t_ve=
endfunction

" Reset 't_ve'.
function! ctrlp#window#exit() abort
	let &t_ve = s:t_ve_saved
endfunction
