"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fern File Explorer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

packadd! fern

let g:fern#default_hidden = 1
let g:fern#renderer#default#leading = ' │'
let g:fern#renderer#default#root_symbol = ' פּ '
let g:fern#renderer#default#leaf_symbol = '  '
let g:fern#renderer#default#collapsed_symbol = '   '
let g:fern#renderer#default#expanded_symbol = '   '
let g:fern#window_selector_use_popup = 1
let g:fern#hide_cursor = 1

nnoremap <silent> <leader><leader> :Fern . -toggle -drawer -width=50 -keep -reveal=%<CR>
inoremap <silent> <leader><leader> <C-O>:Fern . -toggle -drawer -width=50 -keep -reveal=% -stay<CR>

augroup fern_custom
	autocmd!
	autocmd FileType fern setlocal norelativenumber nonumber
		\ statusline=%!ui#segment#render(fern#theme#build_segments()) |
		\ call fern#mappings#init()
	autocmd User FernHighlight call fern#theme#highlights()
augroup END

