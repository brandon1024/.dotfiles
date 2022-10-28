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

	return statusline#Segment(l:modedata['v'], l:modedata['c'])
endfunction

" A segment indicating if 'paste' is enabled.
function! s:PasteSegment(color) abort
	return statusline#Segment(&paste ? 'PASTE' : '', a:color)
endfunction

" A segment indicating if the buffer is readonly.
function! s:ReadOnlyBufferSegment(color) abort
	return statusline#Segment(&readonly ? '%R' : '', a:color)
endfunction

" A segment for the filename of the current buffer.
function! s:FileNameSegment(color) abort
	return statusline#Segment('%t', a:color)
endfunction

" A segment for the current buffer number.
function! s:BufferNumberSegment(color) abort
	return statusline#Segment('%n', a:color)
endfunction

" A segment for the current file encoding.
function! s:FileInfoSegment(color) abort
	return statusline#Segment((&fileencoding ? &fileencoding : &encoding) .
		\ ' [' . (&filetype ?? '?') . ']', a:color)
endfunction

" A segment for the current line progress percentage.
function! s:PercentageSegment(color) abort
	return statusline#Segment('%p%% ≣', a:color)
endfunction

" A segment for the cursor position.
function! s:CursorPositionSegment(color) abort
	return statusline#Segment('%l:%c', a:color)
endfunction

" Make some final adjustments to segments.
function! s:SegmentInactiveProcessor(segment) abort
	if get(a:segment, 'flag', '') == 'x'
		return a:segment
	endif

	" choose a color based on whether the window is active or not
	let l:win_active = g:statusline_winid == win_getid()
	let a:segment['color'] = ['StatuslineLightBg', a:segment['color']][l:win_active]

	" add padding
	if !empty(a:segment['text'])
		let a:segment['text'] = ' ' . a:segment['text'] . ' '
	endif

	return a:segment
endfunction

" Render the statusline.
function! RenderStatusline() abort
	let l:segments = map([
		\ s:ModeSegment(),
		\ statusline#SpacerSegment('StatuslineDarkerBg', { 'flag': 'x' }),
		\ s:PasteSegment('StatuslineDarkBg'),
		\ s:ReadOnlyBufferSegment('StatuslineDarkBg'),
		\ s:BufferNumberSegment('StatuslineDarkBg'),
		\ s:FileNameSegment('StatuslineDarkBg'),
		\ statusline#AlignmentSegment('StatuslineDarkBg', { 'flag': 'x' }),
		\ s:FileInfoSegment('StatuslineLightBg'),
		\ statusline#SpacerSegment('StatuslineDarkerBg', { 'flag': 'x' }),
		\ s:PercentageSegment('StatuslineOrngBg'),
		\ s:CursorPositionSegment('StatuslineOrngBg')
	\ ], { _, seg -> s:SegmentInactiveProcessor(seg) })
	
	return statusline#CompileSegments(l:segments)
endfunction

set statusline=%!RenderStatusline()

