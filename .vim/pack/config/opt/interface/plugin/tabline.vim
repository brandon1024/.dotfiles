"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Configure Tabline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" always show the tabline
set showtabline=2

function! s:WithSegmentSpacing(segments) abort
	return flatten(map(a:segments,
		\ { idx, val -> [val, statusline#SpacerSegment('StatuslineDarkBg')] }))[0:-2]
endfunction

function! s:TabSegments(current) abort
	let l:segments = []

	for i in range(1, tabpagenr('$'))
		let l:color = (i == a:current) ? 'StatuslineBlueBg' : 'StatuslineLightBg'
		call add(l:segments, statusline#Segment(' ‹' . i . '› ', l:color))
	endfor

	return s:WithSegmentSpacing(l:segments)
endfunction

function! s:BufferSegments(current) abort
	let l:segments = []

	for buf in getbufinfo({ 'buflisted': 1 })
		let l:bname = fnamemodify(buf['name'] ?? 'empty', ':t')
		let l:bnum = buf['bufnr']

		let l:color = (l:bnum == a:current) ? 'StatuslineBlueBg' : 'StatuslineLightBg'
		let l:text = ' ' . l:bnum . ' ' . l:bname . ' ' . ((l:bnum == a:current) ? ' ' : ' ')

		call add(l:segments, statusline#Segment(l:text, l:color))
	endfor

	return s:WithSegmentSpacing(l:segments)
endfunction

" Render the tabline.
function! RenderTabline() abort
	return statusline#CompileSegments(flatten([
		\ statusline#SpacerSegment('StatuslineDarkBg'),
		\ s:BufferSegments(bufnr('%')),
		\ statusline#AlignmentSegment('StatuslineDarkBg'),
		\ s:TabSegments(tabpagenr()),
		\ statusline#SpacerSegment('StatuslineDarkBg'),
		\ statusline#Segment(' 缾', 'StatuslineDarkBg'),
		\ statusline#SpacerSegment('StatuslineDarkBg'),
	\ ]))
endfunction

" format the tabline
set tabline=%!RenderTabline()

