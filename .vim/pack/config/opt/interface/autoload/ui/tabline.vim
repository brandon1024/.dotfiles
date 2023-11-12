"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Utilities for Building Tabline Format Strings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Map color group names to tabline components.
function! ui#tabline#colors() abort
	return {
		\ 'tl_bg': 'ThemeTablineBackground',
		\ 'tl_active': 'ThemeTablineActive',
		\ 'tl_active_mod': 'ThemeTablineActiveModified',
		\ 'tl_active_sym': 'ThemeTablineActiveSym',
		\ 'tl_inactive': 'ThemeTablineInactive',
		\ 'tl_inactive_mod': 'ThemeTablineInactiveModified',
		\ 'tl_inactive_sym': 'ThemeTablineInactiveSym',
		\ 'tl_vim': 'ThemeTablineVim',
	\ }
endfunction

" Build statusline segments for the current window.
function! ui#tabline#build_segments() abort
	let l:colors = ui#tabline#colors()

	let l:leading = [
		\ ui#segment#new('    ', l:colors['tl_vim'])
	\ ]

	let l:tailing = [
		\ ui#segment#spacer(l:colors['tl_bg']),
		\ s:segments_tabs(tabpagenr(), l:colors),
		\ ui#segment#spacer(l:colors['tl_bg']),
		\ ui#segment#new('󰓩 ', l:colors['tl_bg']),
		\ ui#segment#spacer(l:colors['tl_bg']),
	\ ]

	let l:max_width = &columns - ui#segment#width(flatten([l:leading, l:tailing]))

	return [
		\ l:leading,
		\ s:segments_buffers(bufnr('%'), l:max_width, l:colors),
		\ ui#segment#justify(l:colors['tl_bg']),
		\ l:tailing,
	\ ]
endfunction

" Build segments for listed buffers.
"   {current} is the buffer number of the current buffer
"   {max_width} is the max screen column width that the segments may occupy
function! s:segments_buffers(current, max_width, colors) abort
	let l:buffers = getbufinfo({ 'buflisted': 1 })

	" if there are no listed buffers open, return empty
	if empty(l:buffers)
		return []
	endif

	" find index of current buffer, or first if no current buffer
	let l:curr_buff_idx = copy(l:buffers)
		\ ->map({ _, val -> val['bufnr'] })
		\ ->index(a:current)
	let l:curr_buff_idx = max([l:curr_buff_idx, 0])

	let l:segments = [s:segment_buffer(l:buffers[l:curr_buff_idx], a:colors, a:current)]

	" the number of tabline screen columns available, minus a small buffer of
	" 8 cols
	let l:columns_remaining = a:max_width - ui#segment#width(l:segments) - 8

	let l:end = [v:false, v:false]

	function! s:segments_at(buffers, pivot, offset, pos) abort closure
		let l:index = a:pos ? a:pivot + a:offset : a:pivot - a:offset

		" out of bounds or already done
		if l:index < 0 || l:index >= len(a:buffers) || l:end[a:pos]
			return []
		endif

		let l:new_segments = [
			\ s:segment_buffer(a:buffers[l:index], a:colors),
		\ ]

		if (l:columns_remaining - ui#segment#width(l:new_segments)) < 0
			let l:end[a:pos] = v:true
			let l:new_segments = [
				\ ui#segment#new(a:pos ? '  ' : '  ', a:colors['tl_inactive']),
				\ ui#segment#spacer(a:colors['tl_bg'])
			\ ]
		endif

		let l:columns_remaining -= ui#segment#width(l:new_segments)

		return a:pos ? reverse(l:new_segments) : l:new_segments
	endfunction

	function! s:traverse_around_pivot(segments, buffers, pivot, offset) abort closure
		" no more buffers
		if (a:pivot + a:offset) >= len(a:buffers) && (a:pivot - a:offset) < 0
			return a:segments
		endif

		let l:head = s:segments_at(a:buffers, a:pivot, a:offset, 0)
		let l:tail = s:segments_at(a:buffers, a:pivot, a:offset, 1)

		" no more space
		if empty(l:head) && empty(l:tail)
			return a:segments
		endif

		return s:traverse_around_pivot(l:head + a:segments + l:tail, a:buffers, a:pivot, a:offset + 1)
	endfunction

	return s:traverse_around_pivot(l:segments, l:buffers, l:curr_buff_idx, 1)
endfunction

" Build tag page segments.
function! s:segments_tabs(current, colors) abort
	let l:segments = []

	for i in range(1, tabpagenr('$'))
		let l:color = (i == a:current) ? a:colors['tl_active'] : a:colors['tl_inactive']
		let l:symbol_color = (i == a:current) ? a:colors['tl_active_sym'] : a:colors['tl_inactive_sym']
		call add(l:segments, [
			\ ui#segment#new('◢', l:symbol_color),
			\ ui#segment#new(' ' . i . ' ', l:color),
			\ ui#segment#new('◤', l:symbol_color),
		\ ])
	endfor

	" add spacing
	return flatten(map(l:segments,
		\ { idx, val -> [val, ui#segment#spacer(a:colors['tl_bg'])] }))[0:-2]
endfunction

" Build a single segment for a buffer.
"   {buffer} is the buffer info
"   {current} is the buffer number of the current buffer
function! s:segment_buffer(buffer, colors, current = -1) abort
	let l:bname = fnamemodify(a:buffer['name'] ?? 'empty', ':t')
	let l:bnum = a:buffer['bufnr']
	let l:bmodified = a:buffer['changed']
	let l:ftype_symbol = nerdfont#find(l:bname)

	let l:color = (l:bnum == a:current) ?
		\ (l:bmodified ? a:colors['tl_active_mod'] : a:colors['tl_active']) :
		\ (l:bmodified ? a:colors['tl_inactive_mod'] : a:colors['tl_inactive'])
	let l:text = ' ' . l:bnum . ': ' . l:ftype_symbol . ' ' . l:bname . ' ' . ((l:bnum == a:current) ? '  ' : '  ')
	let l:symbol_color = (l:bnum == a:current) ? a:colors['tl_active_sym'] : a:colors['tl_inactive_sym']

	return [
		\ ui#segment#new('◢', l:symbol_color),
		\ ui#segment#new(l:text, l:color),
		\ ui#segment#new('◤', l:symbol_color),
	\ ]
endfunction
