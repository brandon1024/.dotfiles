"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [normal] tab shortcuts
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprev<CR>
nnoremap <leader>te :tabe<Space>

" [normal] swtich between buffers
nnoremap <leader>m :bnext<CR>
nnoremap <leader>n :bprev<CR>

" toggle paste mode
set pastetoggle=<leader>p

" [normal] toggle listchars
nnoremap <leader>l :set list!<CR>

" [insert] unindent
inoremap <S-Tab> <C-d>

" [normal] indent and unindent
nnoremap <S-Tab> <<
nnoremap <Tab> >>

" [visual] indent and unindent
vnoremap <Tab> >
vnoremap <S-Tab> <

function! CloseWindowlessBuffers()
	let l:buffers = filter(getbufinfo({'buflisted': 1, 'hidden': 0}),
			\ { i, b -> !len(b['windows']) })
	for b in l:buffers
		execute 'bd ' . b['bufnr']
	endfor
endfunction

" [normal] close all buffers not displayed in a window
nnoremap <silent> <leader>x :call CloseWindowlessBuffers()<CR>

