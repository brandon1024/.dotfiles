"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mapping Helper Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Close (bdelete) any buffers now shown in a window.
function! mappings#close_windowless_buffers() abort
	function! s:do_close(id, result) abort closure
		if a:result == 0
			return
		endif

		let l:buffers = getbufinfo({'buflisted': 1})
			\ ->filter({ i, b -> !len(b['windows']) })
		for b in l:buffers
			execute 'bd ' . b['bufnr']
		endfor

		redrawtabline
	endfunction

	call popup_dialog(['You are about to close buffers not shown in a window.', 'Proceed? (Yes/no)'], {
		\ 'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
		\ 'filter': 'popup_filter_yesno',
		\ 'callback': function('s:do_close')
	\ })
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
