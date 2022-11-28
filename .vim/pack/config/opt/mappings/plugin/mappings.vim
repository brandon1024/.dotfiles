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

function! s:ToggleQuickFixWindow()
	" find quickfix window in this tab
	let l:qf_win = filter(getwininfo(),
		\ { idx, val -> val['quickfix'] && val['tabnr'] == tabpagenr() })

	if len(l:qf_win)
		cclose
	else
		bo copen 16
	endif
endfunction

" [normal] open quickfix (docked)
nnoremap <silent> <leader>q :call <SID>ToggleQuickFixWindow()<CR>

" [normal] go to next/previous quickfix item
nnoremap <silent> <leader>- :cprev<CR>
nnoremap <silent> <leader>= :cnext<CR>

" [normal] resize by 5
nnoremap <silent> <leader>= :resize +5<cr>
nnoremap <silent> <leader>- :resize -5<cr>
nnoremap <silent> <leader>+ :vertical resize -20<cr>
nnoremap <silent> <leader>_ :vertical resize +20<cr>

