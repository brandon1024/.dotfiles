"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" [normal] switch between buffers
nnoremap <silent> <leader>m :bnext<CR>
nnoremap <silent> <leader>n :bprev<CR>

" [normal] switch between tabs
nnoremap <silent> <leader>M :tabnext<CR>
nnoremap <silent> <leader>N :tabprev<CR>

" [normal / insert] toggle paste mode
set pastetoggle=<leader>p

" [normal] close all buffers not displayed in a window
nnoremap <silent> <leader>x :call mappings#close_windowless_buffers()<CR>

" [normal] open current buffer in a new tab
nnoremap <C-w>z :execute 'tabe +' . line('.') . ' %'<CR>

" [normal] open quickfix (docked)
nnoremap <silent> <leader>q :call mappings#toggle_quickfix_window(v:false)<CR>

" [normal] resize by 5
nnoremap <silent> <leader>= :resize +5<CR>
nnoremap <silent> <leader>- :resize -5<CR>
nnoremap <silent> <leader>+ :vertical resize -20<CR>
nnoremap <silent> <leader>_ :vertical resize +20<CR>

" [normal] search recursively for word under cursor
nnoremap <silent> <ESC><C-]> :call mappings#search_keyword(expand('<cword>'))<CR>

" [visual] search recursively for visually selected text
vnoremap <silent> <ESC><C-]> :call mappings#search_keyword_selected()<CR>

" [normal] replay macro recorded in `q` register
nnoremap <silent> Q @q

" comment/uncomment things
nnoremap <silent> gcc :call comments#toggle_comment_line(line('.'), line('.'))<CR>
xnoremap <silent> gc :<C-U>call comments#toggle_comment_line(line("'<"), line("'>"))<CR>

" [normal] like :tselect, except show popup instead
nnoremap <silent> <C-]> :call tag#step_into(expand('<cword>'))<CR>

" [normal] make K act like J (my sausage fingers hit this accidentally)
nnoremap <silent> K kJ

" [visual] fast yank to system clipboard with <C-Y>
vnoremap <silent> <C-Y> "+y`>

" [normal] run git-blame and write to quickfix list
nnoremap <silent> <leader>gb :call git#blame_qf(expand('%'))<CR>

" [normal] run git-status and write to quickfix list
nnoremap <silent> <leader>gs :call git#status_qf()<CR>
