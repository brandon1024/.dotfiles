"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Configure Tabline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" always show the tabline
set showtabline=2

" Pretty icon segment.
function! s:IconSegment(color) abort
	return statusline#Segment('⋰ ', a:color)
endfunction

" The tab page number segment.
function! s:TabPageSegment(tabnum, color) abort
	return statusline#Segment('‹' . a:tabnum . '›', a:color,
		\ { 'tabnum': a:tabnum })
endfunction

" Buffer segment.
function! s:BufferSegment(buf, color, tabnum) abort
	let l:bname = fnamemodify(a:buf['name'] ?? 'empty', ':t')
	let l:bnum = a:buf['bufnr']

	return statusline#Segment(l:bnum . ' ' . l:bname, a:color,
		\ { 'tabnum': a:tabnum, 'curwin': l:bnum == bufnr('%') })
endfunction

" Get a list of buffer segments for a specific tab number.
function! s:BufferSegments(tabnum)
	" skip buffers in other tabs
	if (a:tabnum + 1) != tabpagenr()
		return []
	endif

	let l:segments = []
	for buf in getbufinfo({ 'buflisted': 1 })
		call add(l:segments, s:BufferSegment(buf, 'StatuslineBlueBg', a:tabnum))
	endfor

	return l:segments
endfunction

" Make some final adjustments to segments.
function! s:SegmentInactiveProcessor(seg) abort
	if get(a:seg, 'flag', '') == 'x'
		return a:seg
	endif

	let l:tabnum = get(a:seg, 'tabnum', -1)
	let l:curwin = get(a:seg, 'curwin', v:true)

	if (l:tabnum + 1) != tabpagenr() || !l:curwin
		let a:seg['color'] = 'StatuslineDarkBg'
	endif

	if !empty(a:seg['text'])
		let a:seg['text'] = ' '. a:seg['text'] . ' '
	endif

	return a:seg
endfunction

" Render the tabline.
function! RenderTabline() abort
	let l:segments = [s:IconSegment('StatuslineDarkBg')]

	for i in range(tabpagenr('$'))
		call add(l:segments, s:TabPageSegment(i, 'StatuslineBlueBg'))
		call add(l:segments, statusline#SpacerSegment('StatuslineDarkBg', { 'flag': 'x' }))
		call extend(l:segments, s:BufferSegments(i))
	endfor

	call add(l:segments, statusline#AlignmentSegment('StatuslineDarkBg'))

	return statusline#CompileSegments(
		\ map(l:segments, { _, seg -> s:SegmentInactiveProcessor(seg) }))
endfunction

" format the tabline
set tabline=%!RenderTabline()

