" Build segment for terminal window.
function! s:TerminalSegment(index, bufnr, current) abort
	let l:text = ' ' . a:bufnr . ' terminal ' . a:index . ' ' . ((a:bufnr == a:current) ? ' ' : ' ')
	return ui#segment#New(l:text, (a:bufnr == a:current) ? 'StatuslineBlueBg' : 'StatuslineLightBg')
endfunction

" Build segments for open terminal windows.
function! s:TerminalSegments(term_buffers, current) abort
	return map(a:term_buffers, { idx, buf -> [
		\ ui#segment#Spacer('StatuslineDarkBg'),
		\ ui#statusline#ShadeInactive(
			\ s:TerminalSegment(idx, buf, a:current),
			\ 'StatuslineLightBg')
	\ ] })
endfunction

" Build segments for the terminal window.
function! ui#terminal#BuildSegments() abort
	return [
		\ ui#statusline#ShadeInactive(
			\ ui#segment#New(' TERMINAL ', 'StatuslineBlueBg'),
			\ 'StatuslineLightBg'),
		\ s:TerminalSegments(term_list(), bufnr('%')),
		\ ui#segment#Justify('StatuslineDarkBg')
	\ ]
endfunction
