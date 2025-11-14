"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git Helper Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Run git blame and write results to quickfix list.
function! git#blame_qf(path) abort
	let l:lnum = 1

	call setqflist([], 'r')

	function! s:stdout_cb(ch, msg) abort closure
		call setqflist([{
			\ 'filename': a:path,
			\ 'lnum': l:lnum,
			\ 'col': 0,
			\ 'text': a:msg,
		\ }], 'a')
		let l:lnum += 1
	endfunction

	function! s:exit_cb(job, status) abort closure
		if a:status != 0
			echohl ErrorMsg | echo 'git: blame exited with status ' . a:status | echohl None
			return
		endif

		call mappings#toggle_quickfix_window(v:true)
	endfunction

	let l:job_opts = {
		\ 'out_mode': 'nl',
		\ 'out_cb': function('s:stdout_cb'),
		\ 'exit_cb': function('s:exit_cb'),
		\ 'in_io': 'null'
	\ }
	let l:job = job_start(['git', '-c', 'blame.coloring=none', 'blame', '--date=short', a:path], l:job_opts)
endfunction

" Run git status and write results to quickfix list.
function! git#status_qf() abort
	call setqflist([], 'r')

	function! s:stdout_cb(ch, msg) abort closure
		let l:parts = split(a:msg)

		call setqflist([{
			\ 'filename': l:parts[1],
			\ 'lnum': 1,
			\ 'col': 0,
			\ 'text': l:parts[0],
		\ }], 'a')
	endfunction

	function! s:exit_cb(job, status) abort closure
		if a:status != 0
			echohl ErrorMsg | echo 'git: status exited with status ' . a:status | echohl None
			return
		endif

		call mappings#toggle_quickfix_window(v:true)
	endfunction

	let l:job_opts = {
		\ 'out_mode': 'nl',
		\ 'out_cb': function('s:stdout_cb'),
		\ 'exit_cb': function('s:exit_cb'),
		\ 'in_io': 'null'
	\ }
	let l:job = job_start(['git', 'status', '--porcelain=v1'], l:job_opts)
endfunction
