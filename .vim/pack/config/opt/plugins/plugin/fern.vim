"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fern File Explorer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

packadd! fern
packadd! fern-renderer-nf

let g:fern#default_hidden = 1
let g:fern#window_selector_use_popup = 1
let g:fern#hide_cursor = 1
let g:fern#renderer = 'brandon1024/fern-renderer-nf.vim'
let g:fern#default_exclude = '\(__pycache__\|.egg-info\|.pytest_cache\|venv\)'
let g:fern#disable_default_mappings = 1

nnoremap <silent> <leader><leader> :Fern . -toggle -drawer -width=50 -keep -reveal=%<CR>
inoremap <silent> <leader><leader> <C-O>:Fern . -toggle -drawer -width=50 -keep -reveal=% -stay<CR>

augroup fern_custom
	autocmd!
	autocmd FileType fern setlocal norelativenumber nonumber
		\ statusline=%!ui#segment#render(fern#theme#build_segments()) |
		\ call fern#mappings#init()
	autocmd User FernHighlight call fern#theme#highlights()
augroup END
