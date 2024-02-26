"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Comment/Uncomment Helper Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! comments#toggle_comment_line(start, end) abort
	" if any lines are commented in this range, let's just comment them all
	" if all lines are commented in this range, let's uncomment them all
	let l:all_commented = v:true
	for lnum in range(a:start, a:end)
		let l:all_commented = l:all_commented && s:is_commented_line(lnum)
	endfor

	for lnum in range(a:start, a:end)
		call s:comment_line(lnum, !l:all_commented && a:start != a:end)
	endfor
endfunction

function! s:comment_line(lnum, force_comment = v:true) abort
	" read the cursor line
	let l:line = getline(a:lnum)

	" isolate leading whitespace from the rest
	let [l:line, l:whitespace, l:rest; _] = matchlist(l:line, '\(^\s*\)\(.*\)')

	if empty(l:rest)
		return
	endif

	" build a pattern that can match for comments
	let l:comment_pat = '^\s*' . substitute(&commentstring, '%s', '\\(.*\\)', '')

	" check if this is a commented line
	let l:results = matchlist(l:line, l:comment_pat)

	if a:force_comment || empty(l:results)
		let l:commented_line = l:whitespace . printf(&commentstring, ' ' . l:rest)
		call setline(a:lnum, l:commented_line)
	else
		call setline(a:lnum, l:whitespace . trim(l:results[1]))
	endif
endfunction

function! s:is_commented_line(lnum) abort
	" read the cursor line
	let l:line = getline(a:lnum)

	" build a pattern that can match for comments
	let l:comment_pat = '^\s*' . substitute(&commentstring, '%s', '\\(.*\\)', '')

	" check if this is a commented line
	let l:results = matchlist(l:line, l:comment_pat)

	return !empty(l:results) || empty(l:line)
endfunction
