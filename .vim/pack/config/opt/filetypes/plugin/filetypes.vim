"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File Type Configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable filetype plugins
filetype plugin on

" disable mappings for filetypes
let g:no_plugin_maps = 1

augroup filetypes_autocmd_group
	autocmd!
	autocmd FileType java,groovy setlocal expandtab textwidth=120
	autocmd FileType c setlocal textwidth=80
	autocmd FileType gitcommit,gitrebase setlocal nonumber norelativenumber nolist showtabline&
	autocmd FileType qf setlocal nobuflisted statusline< nolist
	autocmd FileType qf call s:quickfix_on_open()
	autocmd FileType vim setlocal tags+=$VIMRUNTIME/doc/tags
	autocmd FileType markdown setlocal textwidth=80
	autocmd FileType python setlocal textwidth=100 formatoptions-=t
	autocmd FileType go setlocal equalprg=gofmt formatprg=gofmt textwidth=120
	autocmd FileType help setlocal colorcolumn=
	autocmd FileType json let &l:formatprg='jq .' | let &l:equalprg='jq .'
augroup END

function! s:quickfix_on_open() abort
	augroup qf_buffer_autogroup
		autocmd! * <buffer>
		autocmd WinClosed <buffer> wincmd p
	augroup END
endfunction
