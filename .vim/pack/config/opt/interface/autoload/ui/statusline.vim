"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Utilities for Building Statusline Format Strings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Build statusline segments for the current window.
function! ui#statusline#BuildSegments() abort
	return [
		\ s:ModeSegment(),
		\ ui#segment#Spacer('StatuslineDarkerBg'),
		\ s:PasteSegment(),
		\ s:ReadOnlyBufferSegment(),
		\ s:BufferNumberSegment(),
		\ s:FileNameSegment(),
		\ ui#segment#Justify('StatuslineDarkBg'),
		\ s:FileInfoSegment(),
		\ ui#segment#Spacer('StatuslineDarkerBg'),
		\ s:PercentageSegment(),
		\ s:CursorPositionSegment()
	\ ]
endfunction

" Override segment color if current window is inactive. Return the segment.
function! ui#statusline#ShadeInactive(segment, inactive_color) abort
	let l:win_active = g:statusline_winid == win_getid()
	let l:new_color = l:win_active ? a:segment['color'] : a:inactive_color

	return extend(a:segment, { 'color': l:new_color })
endfunction

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

	return ui#statusline#ShadeInactive(
		\ ui#segment#New(' ' . l:modedata['v'] . ' ', l:modedata['c']),
		\ 'StatuslineLightBg')
endfunction

" A segment indicating if 'paste' is enabled.
function! s:PasteSegment() abort
	return ui#segment#New(&paste ? ' PASTE ' : '', 'StatuslineDarkBg')
endfunction

" A segment indicating if the buffer is readonly.
function! s:ReadOnlyBufferSegment() abort
	return ui#segment#New(&readonly ? ' %R ' : '', 'StatuslineDarkBg')
endfunction

" A segment for the filename of the current buffer.
function! s:FileNameSegment() abort
	return ui#segment#New(' %t ', 'StatuslineDarkBg')
endfunction

" A segment for the current buffer number.
function! s:BufferNumberSegment() abort
	return ui#segment#New(' %n ', 'StatuslineDarkBg')
endfunction

" A segment for the current file encoding.
function! s:FileInfoSegment() abort
	return ui#segment#New(' ' . (&fileencoding ? &fileencoding : &encoding) .
		\ ' [' . (&filetype ?? '?') . '] ', 'StatuslineLightBg')
endfunction

" A segment for the current line progress percentage.
function! s:PercentageSegment() abort
	return ui#statusline#ShadeInactive(
		\ ui#segment#New(' %p%% ≣ ', 'StatuslineOrngBg'),
		\ 'StatuslineLightBg')
endfunction

" A segment for the cursor position.
function! s:CursorPositionSegment() abort
	return ui#statusline#ShadeInactive(
		\ ui#segment#New(' %l:%c ', 'StatuslineOrngBg'),
		\ 'StatuslineLightBg')
endfunction

