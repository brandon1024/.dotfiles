function! fern#theme#highlights() abort
	highlight link FernRootSymbol ThemeBlue
	highlight link FernBranchSymbol ThemeBlue
	highlight link FernLeafSymbol ThemeOrange
	highlight link FernLeaderSymbol ThemeGrey

	highlight link FernRootText ThemeTeal
	highlight link FernBranchText Normal
	highlight link FernLeafText Normal

	highlight link FernMarkedLine CursorLine
	highlight link FernMarkedText Normal

	highlight link FernSpecialNode ThemeGrey

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
	let l:colors = fern#theme#colors()

	return [
		\ ui#segment#justify(l:colors['sl_bg']),
		\ ui#segment#new(' 🌿 ', l:colors['sl_bg']),
		\ ui#statusline#shade_inactive(
			\ ui#segment#new('  FERN  ', l:colors['sl_active']),
			\ l:colors['sl_inactive'])
	\ ]
endfunction

" Map color group names to statusline components.
function! fern#theme#colors() abort
	return {
		\ 'sl_bg': 'ThemeStatuslineBackground',
		\ 'sl_active': 'ThemeTablineActive',
		\ 'sl_active_sym': 'ThemeTablineActiveSym',
		\ 'sl_inactive': 'ThemeTablineInactive',
		\ 'sl_inactive_sym': 'ThemeTablineInactiveSym',
	\ }
endfunction
