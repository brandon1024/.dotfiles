"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Utilities for Building Statusline/Tabline Segments
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" An arbitrary text segment.
function! ui#segment#New(text, color, props = {}) abort
	return extend({ 'text': a:text, 'color': a:color }, a:props)
endfunction

" An segment splitting left/right aligned items.
function! ui#segment#Justify(color, props = {}) abort
	return ui#segment#New('%=', a:color, a:props)
endfunction

" A single space segment.
function! ui#segment#Spacer(color, props = {}) abort
	return ui#segment#New(' ', a:color, a:props)
endfunction

" Compile segments into a single statusline/tabline format string.
function! ui#segment#Render(segments) abort
	let l:fmt = ''

	let l:last_color = v:null
	for segment in filter(flatten(a:segments), { _, seg -> !empty(seg['text']) })
		" add color format string if segment color changes
		if l:last_color != segment['color']
			let l:last_color = segment['color']
			let l:fmt .= s:FormatColor(segment['color'])
		endif

		let l:fmt .= segment['text']
	endfor

	return l:fmt
endfunction

" Calculate the number of screen columns occupied by the given segments.
"
" This function calculates the display width of the segment 'text' values.
" This will not behave correctly if text values already contain formatting
" information (format strings starting with %).
function! ui#segment#Width(segments) abort
	return reduce(a:segments, { acc, val -> acc + strdisplaywidth(val.text) }, 0)
endfunction

" Return a format string for the given color.
function! s:FormatColor(color_name)
	return '%#' . a:color_name . '#'
endfunction

