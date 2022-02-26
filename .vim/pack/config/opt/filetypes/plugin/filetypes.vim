"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File Type Configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enable filetype plugins
filetype plugin on


augroup filetypes_autocmd_group
	autocmd!
	autocmd FileType java,groovy setlocal expandtab
	autocmd FileType gitcommit,gitrebase set nonumber norelativenumber nolist statusline= tabline= showtabline=1 colorcolumn=140
augroup END

