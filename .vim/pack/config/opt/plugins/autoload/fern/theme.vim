function! fern#theme#highlights() abort
	highlight link FernRootSymbol ThemeBlue
	highlight link FernBranchSymbol ThemeBlue
	highlight link FernLeafSymbol ThemeOrange
	highlight link FernLeaderSymbol ThemeGrey

	highlight link FernRootText ThemeTeal
	highlight link FernBranchText ThemeTeal
	highlight link FernLeafText Normal

	highlight default link FernLeafSymbolBlue   ThemeBlue
	highlight default link FernLeafSymbolGreen  ThemeGreen
	highlight default link FernLeafSymbolGrey   ThemeGrey
	highlight default link FernLeafSymbolRed    ThemeRed
	highlight default link FernLeafSymbolPurple ThemePurple
	highlight default link FernLeafSymbolYellow ThemeYellow
	highlight default link FernLeafSymbolPink   ThemePink
	highlight default link FernLeafSymbolTeal   ThemeTeal
endfunction

" Build segments for the fern window.
function! fern#theme#build_segments() abort
	return [
		\ ui#statusline#shade_inactive(
			\ ui#segment#new(' 🌿 FERN ', 'ThemeStatuslineModeNormal'),
			\ 'ThemeStatuslineInactive'),
		\ ui#segment#spacer('ThemeStatuslineBackground'),
		\ ui#segment#justify('ThemeStatuslineBackground'),
		\ ui#segment#new(' ' . fnamemodify(getcwd(), ':t') . ' ', 'ThemeStatuslineBackground')
	\ ]
endfunction

