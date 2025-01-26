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

" Same as mappings#search_keyword, but searches for visually selected text.
function! mappings#search_keyword_selected() abort
	let l:selected_text = getline("'<")[col("'<")-1 : col("'>")-1]
	let l:escaped_text = escape(l:selected_text, '\/.*$^~[]')

	call mappings#search_keyword(l:escaped_text)
endfunction
