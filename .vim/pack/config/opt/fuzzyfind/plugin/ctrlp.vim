"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fuzzy Finding (CtrlP)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
packadd ctrlp

" search from the cwd, not from whatever file happens to be open
let g:ctrlp_working_path_mode = 'w'

" show hidden files (dotfiles)
let g:ctrlp_show_hidden = 1

" show ctrlp window with CTRL+Space
nnoremap <silent> <C-@> :CtrlP<CR>

