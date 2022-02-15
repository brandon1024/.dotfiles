"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Vim Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" configure history
set history=500

" enable filetype plugins
filetype plugin on

" set to auto read when a file is changed from the outside
set autoread

" configure search path
set path+=**

" ignore case when searching, unless there's an uppercase in search query
set ignorecase smartcase

" navigate to search results as you type
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" enable wiLd menu for easier command completion
set wildmenu
set wildmode=longest,list,full
set wildignore=*.so,*.o,*.class

" disable backups and swap files
set nowb noswapfile

