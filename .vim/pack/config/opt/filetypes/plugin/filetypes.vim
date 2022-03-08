"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File Type Configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enable filetype plugins
filetype plugin on

augroup filetypes_autocmd_group
	autocmd!
	autocmd FileType java,groovy setlocal expandtab colorcolumn=140
	autocmd FileType gitcommit,gitrebase set nonumber norelativenumber nolist statusline= tabline= showtabline=1
augroup END

