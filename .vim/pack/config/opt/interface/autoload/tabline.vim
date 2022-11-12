" Calculate the number of screen columns occupied by the given segments.
function! tabline#ScreenColsForSegments(segments) abort
	return reduce(a:segments, { acc, val -> acc + strdisplaywidth(val.text) }, 0)
endfunction

" Build segments for listed buffers.
"   {current} is the buffer number of the current buffer
"   {max_width} is the max screen column width that the segments may occupy
function! tabline#BufferSegments(current, max_width) abort
	let l:buffers = getbufinfo({ 'buflisted': 1 })

	" find index of current buffer, or first if no current buffer
	let l:curr_buff_idx = copy(l:buffers)
		\ ->map({ _, val -> val['bufnr'] })
		\ ->index(a:current)
	let l:curr_buff_idx = max([l:curr_buff_idx, 0])

	let l:segments = [s:BufferSegment(l:buffers[l:curr_buff_idx], a:current)]

	" the number of tabline screen columns available, minus a small buffer of
	" 8 cols
	let l:columns_remaining = a:max_width - tabline#ScreenColsForSegments(l:segments) - 8

	let l:end = [v:false, v:false]

	function! s:SegmentsAt(buffers, pivot, offset, pos) abort closure
		let l:index = a:pos ? a:pivot + a:offset : a:pivot - a:offset

		" out of bounds or already done
		if l:index < 0 || l:index >= len(a:buffers) || l:end[a:pos]
			return []
		endif

		let l:new_segments = [
			\ s:BufferSegment(a:buffers[l:index]),
			\ statusline#SpacerSegment('StatuslineDarkBg')
		\ ]

		if (l:columns_remaining - tabline#ScreenColsForSegments(l:new_segments)) < 0
			let l:end[a:pos] = v:true
			let l:new_segments = [
				\ statusline#Segment(a:pos ? ' › ' : ' ‹ ', 'StatuslineLightBg'),
				\ statusline#SpacerSegment('StatuslineDarkBg')
			\ ]
		endif

		let l:columns_remaining -= tabline#ScreenColsForSegments(l:new_segments)

		return a:pos ? reverse(l:new_segments) : l:new_segments
	endfunction

	function! s:TraverseAroundPivot(segments, buffers, pivot, offset) abort closure
		" no more buffers
		if (a:pivot + a:offset) >= len(a:buffers) && (a:pivot - a:offset) < 0
			return a:segments
		endif

		let l:head = s:SegmentsAt(a:buffers, a:pivot, a:offset, 0)
		let l:tail = s:SegmentsAt(a:buffers, a:pivot, a:offset, 1)

		" no more space
		if empty(l:head) && empty(l:tail)
			return a:segments
		endif

		return s:TraverseAroundPivot(l:head + a:segments + l:tail, a:buffers, a:pivot, a:offset + 1)
	endfunction

	return s:TraverseAroundPivot(l:segments, l:buffers, l:curr_buff_idx, 1)
endfunction

" Build tag page segments.
function! tabline#TabSegments(current) abort
	let l:segments = []

	for i in range(1, tabpagenr('$'))
		let l:color = (i == a:current) ? 'StatuslineBlueBg' : 'StatuslineLightBg'
		call add(l:segments, statusline#Segment(' ‹' . i . '› ', l:color))
	endfor

	" add spacing
	return flatten(map(l:segments,
		\ { idx, val -> [val, statusline#SpacerSegment('StatuslineDarkBg')] }))[0:-2]
endfunction

" Build a single segment for a buffer.
"   {buffer} is the buffer info
"   {current} is the buffer number of the current buffer
function! s:BufferSegment(buffer, current = -1) abort
	let l:bname = fnamemodify(a:buffer['name'] ?? 'empty', ':t')
	let l:bnum = a:buffer['bufnr']

	let l:color = (l:bnum == a:current) ? 'StatuslineBlueBg' : 'StatuslineLightBg'
	let l:text = ' ' . l:bnum . ' ' . l:bname . ' ' . ((l:bnum == a:current) ? ' ' : ' ')

	return statusline#Segment(l:text, l:color)
endfunction

