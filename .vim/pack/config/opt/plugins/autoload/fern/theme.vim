function! fern#theme#highlights() abort
	highlight link FernRootSymbol StatuslineBlueFg
	highlight link FernBranchSymbol StatuslineBlueFg
	highlight link FernLeafSymbol StatuslineOrngFg
	highlight link FernLeaderSymbol StatuslineLightFg

	highlight link FernRootText Normal
	highlight link FernBranchText Normal
	highlight link FernLeafText Normal

	highlight default link FernLeafSymbolBlue   StatuslineBlueFg
	highlight default link FernLeafSymbolGreen  StatuslineGreenFg
	highlight default link FernLeafSymbolGrey   StatuslineLighterFg
	highlight default link FernLeafSymbolRed    StatuslineRedFg
	highlight default link FernLeafSymbolPurple StatuslinePurpleFg
	highlight default link FernLeafSymbolYellow StatuslineYellowFg
	highlight default link FernLeafSymbolPink   StatuslinePinkFg
	highlight default link FernLeafSymbolTeal   StatuslineTealFg
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

