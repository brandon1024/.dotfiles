"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" scrolloff (show 7 lines above/below when navigating a file)
set so=7

" show line numbers
set number relativenumber

" Show matching brackets when text indicator is over them
set showmatch

" enable syntax highlighting
syntax enable

" enable true colors
set termguicolors
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"

" add onedark plugin and set colorscheme
packadd! onedark
colorscheme onedark

" configure color column (line length guide)
set colorcolumn=80

" configure vertical split column
set fillchars+=vert:│

" show tabs and spaces
set list listchars=space:·,tab:──·

" always show the status line
set laststatus=2

" don't show the mode under statusline
" the mode is already shown in the statusline
set noshowmode

" show cursor line in different color
set cul

" use bar instead of blocking block while in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

