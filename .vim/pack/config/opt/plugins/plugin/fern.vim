"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fern File Explorer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

packadd! fern

let g:fern#default_hidden = 1
let g:fern#renderer#default#leading = '  '
let g:fern#renderer#default#root_symbol = ' פּ '
let g:fern#renderer#default#leaf_symbol = '  '
let g:fern#renderer#default#collapsed_symbol = '   '
let g:fern#renderer#default#expanded_symbol = '   '
let g:fern#hide_cursor = 1

nnoremap <silent> <C-e> :Fern . -toggle -drawer -width=50 -keep -reveal=%<CR>

function! RenderFernStatusline() abort
	return statusline#CompileSegments([
		\ statusline#Segment(' 🌿 ', 'StatuslineDarkBg'),
		\ statusline#Segment(' FERN ', 'StatuslineBlueBg'),
		\ statusline#SpacerSegment('StatuslineDarkerBg'),
		\ statusline#AlignmentSegment('StatuslineDarkBg'),
		\ statusline#Segment(' ' . fnamemodify(getcwd(), ':t') . ' ', 'StatuslineLightBg')
	\ ])
endfunction

function! s:CustomHighlights() abort
	highlight link FernRootText Normal
	highlight link FernRootSymbol Directory
	highlight link FernBranchText Normal
	highlight link FernBranchSymbol Directory
	highlight link FernLeafText Normal
	highlight link FernLeafSymbol WarningMsg
endfunction

function! s:InitMappings() abort
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
	autocmd FileType fern setlocal norelativenumber nonumber statusline=%!RenderFernStatusline() | call s:InitMappings()
	autocmd User FernHighlight call s:CustomHighlights()
augroup END

