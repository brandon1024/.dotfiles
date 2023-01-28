"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" [normal] swtich between buffers
nnoremap <silent> <leader>m :bnext<CR>
nnoremap <silent> <leader>n :bprev<CR>

" toggle paste mode
set pastetoggle=<leader>p

" [normal] toggle listchars
nnoremap <silent> <leader>l :set list!<CR>

function! s:CloseWindowlessBuffers()
	let l:buffers = filter(getbufinfo({'buflisted': 1}),
			\ { i, b -> !len(b['windows']) })
	for b in l:buffers
		execute 'bd ' . b['bufnr']
	endfor
endfunction

" [normal] close all buffers not displayed in a window
nnoremap <silent> <leader>x :call <SID>CloseWindowlessBuffers()<CR>

" [normal] open current buffer in a new tab
nnoremap <C-w>z :execute 'tabe +' . line('.') . ' %'<CR>

function! s:ToggleQuickFixWindow(keep_open)
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

" [normal] open quickfix (docked)
nnoremap <silent> <leader>q :call <SID>ToggleQuickFixWindow(v:false)<CR>

" [normal] resize by 5
nnoremap <silent> <leader>= :resize +5<CR>
nnoremap <silent> <leader>- :resize -5<CR>
nnoremap <silent> <leader>+ :vertical resize -20<CR>
nnoremap <silent> <leader>_ :vertical resize +20<CR>

function! s:SearchKeyword(keyword) abort
	try
		execute 'vim /' . a:keyword . '/jg **/*.' . fnamemodify(expand('%'), ':e') ?? '*'
	catch
		echohl ErrorMsg | echo 'keyword not found: ' . a:keyword | echohl None
		return
	endtry

	call s:ToggleQuickFixWindow(v:true)
endfunction

" [normal] search recursively for word under cursor
nnoremap <silent> <ESC><C-]> :call <SID>SearchKeyword(expand('<cword>'))<CR>

" [normal] replay macro recorded in `q` register
nnoremap <silent> Q @q

