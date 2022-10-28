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

" configure color column (line length guide)
set colorcolumn=80

" configure vertical split column
set fillchars+=vert:│

" show tabs and spaces
set list listchars=space:·,tab:──·,trail:▓

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

" split new panes to the right and below
set splitright
set splitbelow

