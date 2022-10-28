"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Utilities for Building Statusline/Tabline Format Strings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" An arbitrary text segment.
function! statusline#Segment(text, color, props = {}) abort
	return extend({ 'text': a:text, 'color': a:color }, a:props)
endfunction

" An segment splitting left/right aligned items.
function! statusline#AlignmentSegment(color, props = {}) abort
	return statusline#Segment('%=', a:color, a:props)
endfunction

" A single space segment.
function! statusline#SpacerSegment(color, props = {}) abort
	return statusline#Segment(' ', a:color, a:props)
endfunction

" Compile segments into a single statusline format string.
function! statusline#CompileSegments(segments) abort
	let l:fmt = ''

	let l:last_color = v:null
	for segment in filter(a:segments, { _, seg -> !empty(seg['text']) })
		" add color format string if segment color changes
		if l:last_color != segment['color']
			let l:last_color = segment['color']
			let l:fmt .= s:FormatColor(segment['color'])
		endif

		let l:fmt .= segment['text']
	endfor

	return l:fmt
endfunction

" Return a format string for the given color.
function! s:FormatColor(color_name)
	return '%#' . a:color_name . '#'
endfunction

