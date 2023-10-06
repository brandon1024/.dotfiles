"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Utilities for Building Statusline Format Strings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Map color group names to statusline components.
function! ui#statusline#colors() abort
	let s:color_palette = NordPalette()

	return {
		\ 'sl_bg': 'ThemeStatuslineBackground',
		\ 'sl_mode': {
			\ 'normal': 'ThemeStatuslineModeNormal',
			\ 'insert': 'ThemeStatuslineModeInsert',
			\ 'replace': 'ThemeStatuslineModeReplace',
			\ 'visual': 'ThemeStatuslineModeVisual',
			\ 'visual-line': 'ThemeStatuslineModeVisualLine',
			\ 'visual-block': 'ThemeStatuslineModeVisualBlock',
			\ 'terminal': 'ThemeStatuslineModeTerminal',
			\ 'other': 'ThemeStatuslineModeOther',
		\ },
		\ 'sl_buf_info': 'ThemeStatuslineBufferInfo',
		\ 'sl_buf_pos': 'ThemeStatuslineBufferPosition',
		\ 'sl_inactive': 'ThemeStatuslineInactive',
	\ }
endfunction

" Build statusline segments for the current window.
function! ui#statusline#build_segments() abort
	let l:colors = ui#statusline#colors()

	return [
		\ s:segment_mode(l:colors),
		\ ui#segment#spacer(l:colors['sl_bg']),
		\ s:segment_paste(l:colors),
		\ s:segment_ro_buffer(l:colors),
		\ s:segment_ftype_symbol(l:colors),
		\ s:segment_bufnr(l:colors),
		\ s:segment_fname(l:colors),
		\ ui#segment#justify(l:colors['sl_bg']),
		\ s:segment_file_info(l:colors),
		\ ui#segment#spacer(l:colors['sl_bg']),
		\ s:segment_percent(l:colors),
		\ s:segment_cursor_pos(l:colors),
	\ ]
endfunction

" Override segment color if current window is inactive. Return the segment.
function! ui#statusline#shade_inactive(segment, inactive_color) abort
	let l:win_active = g:statusline_winid == win_getid()
	let l:new_color = l:win_active ? a:segment['color'] : a:inactive_color

	return extend(a:segment, { 'color': l:new_color })
endfunction

" A segment for the current mode.
function! s:segment_mode(colors) abort
	let l:modemap = {
		\ 'n': {'v': 'NORMAL', 'c': a:colors['sl_mode']['normal']},
		\ 'i': {'v': 'INSERT', 'c': a:colors['sl_mode']['insert']},
		\ 'R': {'v': 'REPLACE', 'c': a:colors['sl_mode']['replace']},
		\ 'v': {'v': 'VISUAL', 'c': a:colors['sl_mode']['visual']},
		\ 'V': {'v': 'VISUAL LINE', 'c': a:colors['sl_mode']['visual-line']},
		\ '\<C-V>': {'v': 'VISUAL BLOCK', 'c': a:colors['sl_mode']['visual-block']},
		\ 't': {'v': 'TERMINAL', 'c': a:colors['sl_mode']['terminal']}
	\ }

	let l:modedata = get(l:modemap, mode()[0:1],
		\ {'v': mode(), 'c': a:colors['sl_mode']['other']})

	return ui#statusline#shade_inactive(
		\ ui#segment#new(' ' . l:modedata['v'] . ' ', l:modedata['c']),
		\ a:colors['sl_inactive'])
endfunction

" A segment indicating if 'paste' is enabled.
function! s:segment_paste(colors) abort
	return ui#segment#new(&paste ? ' PASTE ' : '', a:colors['sl_bg'])
endfunction

" A segment indicating if the buffer is readonly.
function! s:segment_ro_buffer(colors) abort
	return ui#segment#new(&readonly ? ' %R ' : '', a:colors['sl_bg'])
endfunction

function! s:segment_ftype_symbol(colors) abort
	return ui#segment#new(nerdfont#find(), a:colors['sl_bg'])
endfunction

" A segment for the current buffer number.
function! s:segment_bufnr(colors) abort
	return ui#segment#new(' %n ', a:colors['sl_bg'])
endfunction

" A segment for the filename of the current buffer.
function! s:segment_fname(colors) abort
	return ui#segment#new(' %t ', a:colors['sl_bg'])
endfunction

" A segment for the current file encoding.
function! s:segment_file_info(colors) abort
	return ui#statusline#shade_inactive(
		\ ui#segment#new(' ' . (&fileencoding ? &fileencoding : &encoding) .
			\ ' [' . (&filetype ?? '?') . '] ', a:colors['sl_buf_info']),
		\ a:colors['sl_inactive'])
endfunction

" A segment for the current line progress percentage.
function! s:segment_percent(colors) abort
	return ui#statusline#shade_inactive(
		\ ui#segment#new(' %p%% ≣ ', a:colors['sl_buf_pos']),
		\ a:colors['sl_inactive'])
endfunction

" A segment for the cursor position.
function! s:segment_cursor_pos(colors) abort
	let l:mode = mode()

	if l:mode =~ '[vV]'
		let l:selected_chars = wordcount().visual_chars
		let l:selected_lines = abs(line('.') - line('v')) + 1
		return ui#statusline#shade_inactive(
			\ ui#segment#new(' ' . l:selected_lines . ':' . l:selected_chars . ' ', a:colors['sl_buf_pos']),
			\ a:colors['sl_inactive'])
	endif

	return ui#statusline#shade_inactive(
		\ ui#segment#new(' %l:%c ', a:colors['sl_buf_pos']),
		\ a:colors['sl_inactive'])
endfunction
