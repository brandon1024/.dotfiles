"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mapping Helper Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Close (bdelete) any buffers now shown in a window.
function! mappings#close_windowless_buffers() abort
	let l:buffers = getbufinfo({'buflisted': 1})
		\ ->filter({ i, b -> !len(b['windows']) })
	for b in l:buffers
		execute 'bd ' . b['bufnr']
	endfor

	redrawtabline
endfunction

" Toggle the quickfix window as a bottom split.
function! mappings#toggle_quickfix_window(keep_open) abort
	" find quickfix window in this tab
	let l:qf_win = filter(getwininfo(),
		\ { idx, val -> val['quickfix'] && val['tabnr'] == tabpagenr() })

	" keep the window open
	if len(l:qf_win) && a:keep_open
		return
	end

	if len(l:qf_win)
		cclose
	else
		bo copen 16
	endif
endfunction

" Recursively from the current working directory, search for a keyword and
" show the results in the quickfix window.
function! mappings#search_keyword(keyword) abort
	try
		execute 'vim /' . a:keyword . '/jg **/*.*'
	catch
		echohl ErrorMsg | echo 'keyword not found: ' . a:keyword | echohl None
		return
	endtry

	call mappings#toggle_quickfix_window(v:true)
endfunction

" Toggle the scratchpad window.
function! mappings#toggle_scratch(open_empty)
	if getbufvar('%', '_scratch', v:false) == v:true
		bd %
		return
	endif

	if a:open_empty
		vnew +setlocal\ nobuflisted\ bufhidden=wipe\ buftype=nofile
	else
		vsplit +setlocal\ nobuflisted\ bufhidden=wipe ~/.scratchpad
	endif

	call setbufvar('%', '_scratch', v:true)
endfunction

function! mappings#toggle_comment_line(start, end) abort
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
