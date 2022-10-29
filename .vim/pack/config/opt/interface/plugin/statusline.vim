"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Configure Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" A segment for the current mode.
function! s:ModeSegment() abort
	let l:modemap = {
		\ 'n': {'v': 'NORMAL', 'c': 'StatuslineBlueBg'},
		\ 'i': {'v': 'INSERT', 'c': 'StatuslinePinkBg'},
		\ 'R': {'v': 'RPLACE', 'c': 'StatuslineTealBg'},
		\ 'v': {'v': 'V CHAR', 'c': 'StatuslineOrngBg'},
		\ 'V': {'v': 'V LINE', 'c': 'StatuslineOrngBg'},
		\ '\<C-V>': {'v': 'VBLOCK', 'c': 'StatuslineOrngBg'},
		\ 't': {'v': ' TERM ', 'c': 'StatuslineDarkerBg'}
	\ }

	let l:modedata = get(l:modemap, mode()[0:1],
		\ {'v': mode(), 'c': 'StatuslineDarkerBg'})

	let l:color = (g:statusline_winid == win_getid()) ? l:modedata['c'] : 'StatuslineLightBg'
	return statusline#Segment(' ' . l:modedata['v'] . ' ', l:color)
endfunction

" A segment indicating if 'paste' is enabled.
function! s:PasteSegment() abort
	return statusline#Segment(&paste ? ' PASTE ' : '', 'StatuslineDarkBg')
endfunction

" A segment indicating if the buffer is readonly.
function! s:ReadOnlyBufferSegment() abort
	return statusline#Segment(&readonly ? ' %R ' : '', 'StatuslineDarkBg')
endfunction

" A segment for the filename of the current buffer.
function! s:FileNameSegment() abort
	return statusline#Segment(' %t ', 'StatuslineDarkBg')
endfunction

" A segment for the current buffer number.
function! s:BufferNumberSegment() abort
	return statusline#Segment(' %n ', 'StatuslineDarkBg')
endfunction

" A segment for the current file encoding.
function! s:FileInfoSegment() abort
	return statusline#Segment(' ' . (&fileencoding ? &fileencoding : &encoding) .
		\ ' [' . (&filetype ?? '?') . '] ', 'StatuslineLightBg')
endfunction

" A segment for the current line progress percentage.
function! s:PercentageSegment() abort
	let l:color = (g:statusline_winid == win_getid()) ? 'StatuslineOrngBg' : 'StatuslineLightBg'
	return statusline#Segment(' %p%% ≣ ', l:color)
endfunction

" A segment for the cursor position.
function! s:CursorPositionSegment() abort
	let l:color = (g:statusline_winid == win_getid()) ? 'StatuslineOrngBg' : 'StatuslineLightBg'
	return statusline#Segment(' %l:%c ', l:color)
endfunction

function! RenderStatusline() abort
	return statusline#CompileSegments([
		\ s:ModeSegment(),
		\ statusline#SpacerSegment('StatuslineDarkerBg'),
		\ s:PasteSegment(),
		\ s:ReadOnlyBufferSegment(),
		\ s:BufferNumberSegment(),
		\ s:FileNameSegment(),
		\ statusline#AlignmentSegment('StatuslineDarkBg'),
		\ s:FileInfoSegment(),
		\ statusline#SpacerSegment('StatuslineDarkerBg'),
		\ s:PercentageSegment(),
		\ s:CursorPositionSegment()
	\ ])
endfunction

set statusline=%!RenderStatusline()

