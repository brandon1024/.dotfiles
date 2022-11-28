"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Utilities for Building Statusline Format Strings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Build statusline segments for the current window.
function! ui#statusline#build_segments() abort
	return [
		\ s:segment_mode(),
		\ ui#segment#spacer('StatuslineDarkerBg'),
		\ s:segment_paste(),
		\ s:segment_ro_buffer(),
		\ s:segment_bufnr(),
		\ s:segment_fname(),
		\ ui#segment#justify('StatuslineDarkBg'),
		\ s:segment_file_info(),
		\ ui#segment#spacer('StatuslineDarkerBg'),
		\ s:segment_percent(),
		\ s:segment_cursor_pos()
	\ ]
endfunction

" Override segment color if current window is inactive. Return the segment.
function! ui#statusline#shade_inactive(segment, inactive_color) abort
	let l:win_active = g:statusline_winid == win_getid()
	let l:new_color = l:win_active ? a:segment['color'] : a:inactive_color

	return extend(a:segment, { 'color': l:new_color })
endfunction

" A segment for the current mode.
function! s:segment_mode() abort
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

	return ui#statusline#shade_inactive(
		\ ui#segment#new(' ' . l:modedata['v'] . ' ', l:modedata['c']),
		\ 'StatuslineLightBg')
endfunction

" A segment indicating if 'paste' is enabled.
function! s:segment_paste() abort
	return ui#segment#new(&paste ? ' PASTE ' : '', 'StatuslineDarkBg')
endfunction

" A segment indicating if the buffer is readonly.
function! s:segment_ro_buffer() abort
	return ui#segment#new(&readonly ? ' %R ' : '', 'StatuslineDarkBg')
endfunction

" A segment for the current buffer number.
function! s:segment_bufnr() abort
	return ui#segment#new(' %n ', 'StatuslineDarkBg')
endfunction

" A segment for the filename of the current buffer.
function! s:segment_fname() abort
	return ui#segment#new(' %t ', 'StatuslineDarkBg')
endfunction

" A segment for the current file encoding.
function! s:segment_file_info() abort
	return ui#segment#new(' ' . (&fileencoding ? &fileencoding : &encoding) .
		\ ' [' . (&filetype ?? '?') . '] ', 'StatuslineLightBg')
endfunction

" A segment for the current line progress percentage.
function! s:segment_percent() abort
	return ui#statusline#shade_inactive(
		\ ui#segment#new(' %p%% ≣ ', 'StatuslineOrngBg'),
		\ 'StatuslineLightBg')
endfunction

" A segment for the cursor position.
function! s:segment_cursor_pos() abort
	return ui#statusline#shade_inactive(
		\ ui#segment#new(' %l:%c ', 'StatuslineOrngBg'),
		\ 'StatuslineLightBg')
endfunction

