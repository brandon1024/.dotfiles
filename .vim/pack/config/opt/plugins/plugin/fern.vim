"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fern File Explorer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

packadd! fern

let g:fern#default_hidden = 1
let g:fern#renderer#default#leading = "  "
let g:fern#renderer#default#leaf_symbol = "   "
let g:fern#renderer#default#collapsed_symbol = " ▶ "
let g:fern#renderer#default#expanded_symbol = " ▼ "

nnoremap <silent> <C-e> :Fern . -toggle -drawer -width=50 -keep -reveal=%<CR>

function! RenderFernStatusline() abort
	return statusline#CompileSegments([
		\ statusline#AlignmentSegment('StatuslineDarkBg'),
		\ statusline#Segment(' FERN ', 'StatuslineBlueBg')
	\ ])
endfunction

function! s:InitFern() abort
	setlocal statusline=%!RenderFernStatusline()

	" define some useful keymaps
	nmap <buffer> cd <Plug>(fern-action-enter)
	nmap <buffer> l <Plug>(fern-action-open-or-enter)
	nmap <buffer> h <Plug>(fern-action-open:split)
	nmap <buffer> v <Plug>(fern-action-open:vsplit)

	nmap <buffer><expr>
		\ <Plug>(fern-action-toggle-expand-open)
		\ fern#smart#leaf(
		\   "<Plug>(fern-action-open)",
		\   "<Plug>(fern-action-expand)",
		\   "<Plug>(fern-action-collapse)")
	nmap <buffer> <CR> <Plug>(fern-action-toggle-expand-open)
endfunction

augroup fern_custom
	autocmd!
	autocmd FileType fern setlocal norelativenumber nonumber | call s:InitFern()
augroup END

