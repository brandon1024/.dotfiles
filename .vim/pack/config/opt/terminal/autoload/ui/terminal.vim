"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Docked Terminal Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Build segments for the terminal window.
function! ui#terminal#build_segments() abort
	return [
		\ ui#statusline#shade_inactive(
			\ ui#segment#new(' TERMINAL ', 'StatuslineBlueBg'),
			\ 'StatuslineLightBg'),
		\ s:segments_terminals(term_list(), bufnr('%')),
		\ ui#segment#justify('StatuslineDarkBg')
	\ ]
endfunction

" Build segment for terminal window.
function! s:segment_terminal(index, bufnr, current) abort
	let l:text = ' ' . a:bufnr . ' terminal ' . a:index . ' ' . ((a:bufnr == a:current) ? ' ' : ' ')
	return ui#segment#new(l:text, (a:bufnr == a:current) ? 'StatuslineBlueBg' : 'StatuslineLightBg')
endfunction

" Build segments for open terminal windows.
function! s:segments_terminals(term_buffers, current) abort
	return map(a:term_buffers, { idx, buf -> [
		\ ui#segment#spacer('StatuslineDarkBg'),
		\ ui#statusline#shade_inactive(
			\ s:segment_terminal(idx, buf, a:current),
			\ 'StatuslineLightBg')
	\ ] })
endfunction

