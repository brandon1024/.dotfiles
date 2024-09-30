function! git#blame_qf(path) abort
	call setqflist([], 'r')

	function! s:stdout_cb(ch, msg) abort closure
		call setqflist([{
			\ 'filename': a:path,
			\ 'lnum': 0,
			\ 'col': 0,
			\ 'text': a:msg,
		\ }], 'a')
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
	let l:job = job_start(['git', 'blame', a:path], l:job_opts)
endfunction
