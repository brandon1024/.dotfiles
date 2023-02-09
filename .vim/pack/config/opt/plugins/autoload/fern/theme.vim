function! fern#theme#highlights() abort
	highlight link FernRootText Normal
	highlight link FernRootSymbol Directory
	highlight link FernBranchText Normal
	highlight link FernBranchSymbol Directory
	highlight link FernLeafText Normal
	highlight link FernLeafSymbol WarningMsg
	highlight link FernLeaderSymbol StatuslineDarkFg
endfunction

" Build segments for the fern window.
function! fern#theme#build_segments() abort
	return [
		\ ui#statusline#shade_inactive(
			\ ui#segment#new(' 🌿 FERN ', 'StatuslineBlueBg'),
			\ 'StatuslineLightBg'),
		\ ui#segment#spacer('StatuslineDarkerBg'),
		\ ui#segment#justify('StatuslineDarkBg'),
		\ ui#segment#new(' ' . fnamemodify(getcwd(), ':t') . ' ', 'StatuslineLightBg')
	\ ]
endfunction

