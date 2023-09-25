"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Docked Terminal Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! ui#terminal#colors() abort
	return {
		\ 'term_bg': 'ThemeTerminalBackground',
		\ 'term_active': 'ThemeTerminalActive',
		\ 'term_inactive': 'ThemeTerminalInactive',
	\ }
endfunction

" Build segments for the terminal window.
function! ui#terminal#build_segments() abort
	let l:colors = ui#terminal#colors()

	return [
		\ s:segments_terminals(term_list(), bufnr('%'), l:colors),
		\ ui#segment#justify(l:colors['term_bg'])
	\ ]
endfunction

" Build segment for terminal window.
function! s:segment_terminal(index, bufnr, current, colors) abort
	let l:text = ' ' . a:bufnr . ' terminal ' . a:index . ' ' . ((a:bufnr == a:current) ? ' ' : ' ')
	return ui#segment#new(l:text, (a:bufnr == a:current) ? a:colors['term_active'] : a:colors['term_inactive'])
endfunction

" Build segments for open terminal windows.
function! s:segments_terminals(term_buffers, current, colors) abort
	return map(a:term_buffers, { idx, buf -> [
		\ ui#segment#spacer(a:colors['term_bg']),
		\ ui#statusline#shade_inactive(
			\ s:segment_terminal(idx, buf, a:current, a:colors),
			\ a:colors['term_inactive'])
	\ ] })
endfunction

