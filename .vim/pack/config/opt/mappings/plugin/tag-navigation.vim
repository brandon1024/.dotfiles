"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Improved Tag Navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" [normal] like :tselect, except show popup instead
nnoremap <silent> <C-]> :call tag#step_into(expand('<cword>'))<CR>

