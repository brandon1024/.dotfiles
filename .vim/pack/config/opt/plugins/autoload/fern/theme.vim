function! fern#theme#highlights() abort
	highlight link FernRootSymbol ThemeColorBlueFg
	highlight link FernBranchSymbol ThemeColorBlueFg
	highlight link FernLeafSymbol ThemeColorOrngFg
	highlight link FernLeaderSymbol ThemeColorLightFg

	highlight link FernRootText Normal
	highlight link FernBranchText Normal
	highlight link FernLeafText Normal

	highlight default link FernLeafSymbolBlue   ThemeColorBlueFg
	highlight default link FernLeafSymbolGreen  ThemeColorGreenFg
	highlight default link FernLeafSymbolGrey   ThemeColorLighterFg
	highlight default link FernLeafSymbolRed    ThemeColorRedFg
	highlight default link FernLeafSymbolPurple ThemeColorPurpleFg
	highlight default link FernLeafSymbolYellow ThemeColorYellowFg
	highlight default link FernLeafSymbolPink   ThemeColorPinkFg
	highlight default link FernLeafSymbolTeal   ThemeColorTealFg
endfunction

" Build segments for the fern window.
function! fern#theme#build_segments() abort
	return [
		\ ui#statusline#shade_inactive(
			\ ui#segment#new(' 🌿 FERN ', 'ThemeColorBlueBg'),
			\ 'ThemeColorLightBg'),
		\ ui#segment#spacer('ThemeColorDarkerBg'),
		\ ui#segment#justify('ThemeColorDarkBg'),
		\ ui#segment#new(' ' . fnamemodify(getcwd(), ':t') . ' ', 'ThemeColorLightBg')
	\ ]
endfunction

