"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Configure Tabline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" always show the tabline
set showtabline=2

" Render the tabline.
function! RenderTabline() abort
	let l:leading = [
		\ statusline#SpacerSegment('StatuslineDarkBg')
	\ ]

	let l:tailing = [
		\ statusline#SpacerSegment('StatuslineDarkBg'),
		\ tabline#TabSegments(tabpagenr()),
		\ statusline#SpacerSegment('StatuslineDarkBg'),
		\ statusline#Segment(' 缾', 'StatuslineDarkBg'),
		\ statusline#SpacerSegment('StatuslineDarkBg'),
	\ ]

	let l:max_width = &columns - tabline#ScreenColsForSegments(flatten([l:leading, l:tailing]))

	return statusline#CompileSegments(flatten([
		\ l:leading,
		\ tabline#BufferSegments(bufnr('%'), l:max_width),
		\ statusline#AlignmentSegment('StatuslineDarkBg'),
		\ l:tailing,
	\ ]))
endfunction

" format the tabline
set tabline=%!RenderTabline()

