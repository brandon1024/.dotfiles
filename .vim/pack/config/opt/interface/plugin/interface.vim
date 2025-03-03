"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Interface Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" scrolloff (show 15 lines above/below when navigating a file)
set so=15

" show (relative) line numbers
set number relativenumber numberwidth=6

" always show the sign column
set signcolumn=yes

" Show matching brackets when text indicator is over them
set showmatch

" enable syntax highlighting
syntax enable

" configure vertical split column
set fillchars+=vert:\ 

" show tabs and spaces
set list listchars=space:·,tab:──·,trail:▓

" show line breaks
set showbreak=↵\ 

" always show the status line
set laststatus=2

" don't show the mode under statusline
" the mode is already shown in the statusline
set noshowmode

" show cursor line in different color
set cursorline

" show the colorcolumn
set colorcolumn=+0

" set the preview window height to 16
set previewheight=16

" use bar instead of blocking block while in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" split new panes to the right and below
set splitright
set splitbelow

" format the statusline
set statusline=%!ui#segment#render(ui#statusline#build_segments())

" always show the tabline
set showtabline=2

" format the tabline
set tabline=%!ui#segment#render(ui#tabline#build_segments())

