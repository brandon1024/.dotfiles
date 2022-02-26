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

" [insert] unindent
inoremap <S-Tab> <C-d>

" [normal] indent and unindent
nnoremap <S-Tab> <<
nnoremap <Tab> >>

" [visual] indent and unindent
vnoremap <Tab> >
vnoremap <S-Tab> <

