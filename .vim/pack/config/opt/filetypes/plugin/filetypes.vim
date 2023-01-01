"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File Type Configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable filetype plugins
filetype plugin on

augroup filetypes_autocmd_group
	autocmd!
	autocmd FileType java,groovy setlocal expandtab colorcolumn=120 textwidth=120
	autocmd FileType gitcommit,gitrebase setlocal nonumber norelativenumber nolist showtabline&
	autocmd FileType qf setlocal nobuflisted statusline<
	autocmd FileType vim setlocal tags+=$VIMRUNTIME/doc/tags
	autocmd FileType markdown setlocal textwidth=80
	autocmd FileType go setlocal equalprg=gofmt formatprg=gofmt
augroup END

