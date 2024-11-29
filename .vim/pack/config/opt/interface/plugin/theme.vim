"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" configure nord to render italic text
let g:nord_italic = 1
let g:nord_italic_comments = 1

" add nord plugin and set colorscheme
packadd! nord
colorscheme nord

" enable true colors
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

augroup nord_theme_overrides
	autocmd!
	autocmd ColorScheme nord call s:configure_colors()
augroup END

" create a new highlight group
function! s:hi(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
  let cmd = ""
  if a:guifg != ""
    let cmd = cmd . " guifg=" . a:guifg
  endif
  if a:guibg != ""
    let cmd = cmd . " guibg=" . a:guibg
  endif
  if a:ctermfg != ""
    let cmd = cmd . " ctermfg=" . a:ctermfg
  endif
  if a:ctermbg != ""
    let cmd = cmd . " ctermbg=" . a:ctermbg
  endif
  if a:attr != ""
    let cmd = cmd . " gui=" . a:attr . " cterm=" . a:attr
  endif
  if a:guisp != ""
    let cmd = cmd . " guisp=" . a:guisp
  endif
  if cmd != ""
    exec "hi " . a:group . cmd
  endif
endfunction

" configure colours
function! s:configure_colors() abort
	let s:color_palette = NordPalette()

	" statusline colors
	call s:hi('ThemeStatuslineBackground', s:color_palette['nord3'], s:color_palette['nord0'], "", "", "", "")
	call s:hi('ThemeStatuslineBufferInfo', "", s:color_palette['nord1'], "NONE", "", "NONE", "")
	call s:hi('ThemeStatuslineBufferPosition', s:color_palette['nord0'], s:color_palette['nord10'], "NONE", "", "NONE", "")
	call s:hi('ThemeStatuslineInactive', "", s:color_palette['nord1'], "NONE", "", "NONE", "")
	call s:hi('ThemeStatuslineModeNormal', s:color_palette['nord0'], s:color_palette['nord10'], "NONE", "", "NONE", "")
	call s:hi('ThemeStatuslineModeInsert', s:color_palette['nord0'], s:color_palette['nord7'], "NONE", "", "NONE", "")
	call s:hi('ThemeStatuslineModeReplace', s:color_palette['nord0'], s:color_palette['nord8'], "NONE", "", "NONE", "")
	call s:hi('ThemeStatuslineModeVisual', s:color_palette['nord0'], s:color_palette['nord12'], "NONE", "", "NONE", "")
	call s:hi('ThemeStatuslineModeVisualLine', s:color_palette['nord0'], s:color_palette['nord12'], "NONE", "", "NONE", "")
	call s:hi('ThemeStatuslineModeVisualBlock', s:color_palette['nord0'], s:color_palette['nord12'], "NONE", "", "NONE", "")
	call s:hi('ThemeStatuslineModeTerminal', "", s:color_palette['nord1'], "NONE", "", "NONE", "")
	call s:hi('ThemeStatuslineModeOther', "", s:color_palette['nord1'], "NONE", "", "NONE", "")

	" tabline colors
	call s:hi('ThemeTablineBackground', s:color_palette['nord3'], s:color_palette['nord1'], "", "", "", "")
	call s:hi('ThemeTablineActive', s:color_palette['nord0'], s:color_palette['nord10'], "", "", "", "")
	call s:hi('ThemeTablineActiveModified', s:color_palette['nord0'], s:color_palette['nord10'], "", "", "italic,bold", "")
	call s:hi('ThemeTablineActiveSym', s:color_palette['nord10'], s:color_palette['nord1'], "", "", "", "")
	call s:hi('ThemeTablineActiveSymInverted', s:color_palette['nord1'], s:color_palette['nord10'], "", "", "", "")
	call s:hi('ThemeTablineInactive', s:color_palette['nord3'], s:color_palette['nord1'], "NONE", "", "NONE", "")
	call s:hi('ThemeTablineInactiveModified', s:color_palette['nord3'], s:color_palette['nord1'], "NONE", "", "italic,bold", "")
	call s:hi('ThemeTablineInactiveSym', s:color_palette['nord1'], s:color_palette['nord1'], "NONE", "", "NONE", "")
	call s:hi('ThemeTablineInactiveSymInverted', s:color_palette['nord1'], s:color_palette['nord1'], "NONE", "", "NONE", "")
	call s:hi('ThemeTablineVim', s:color_palette['nord14'], s:color_palette['nord1'], "", "", "", "")

	" terminal colors
	call s:hi('ThemeTerminalBackground', s:color_palette['nord3'], s:color_palette['nord0'], "", "", "", "")
	call s:hi('ThemeTerminalActive', s:color_palette['nord0'], s:color_palette['nord10'], "", "", "", "")
	call s:hi('ThemeTerminalInactive', "", s:color_palette['nord1'], "NONE", "", "NONE", "")

	" colors
	call s:hi('ThemeBlue', s:color_palette['nord10'], "", "", "", "", "")
	call s:hi('ThemeGreen', s:color_palette['nord14'], "", "NONE", "", "NONE", "")
	call s:hi('ThemeRed', s:color_palette['nord11'], "", "", "", "", "")
	call s:hi('ThemeYellow', s:color_palette['nord13'], "", "NONE", "", "NONE", "")
	call s:hi('ThemeOrange', s:color_palette['nord12'], "", "NONE", "", "NONE", "")
	call s:hi('ThemePurple', s:color_palette['nord15'], "", "NONE", "", "NONE", "")
	call s:hi('ThemePink', s:color_palette['nord8'], "", "NONE", "", "NONE", "")
	call s:hi('ThemeTeal', s:color_palette['nord7'], "", "NONE", "", "NONE", "")
	call s:hi('ThemeGrey', s:color_palette['nord3'], "", "NONE", "", "NONE", "")
	call s:hi('ThemeLightGrey', s:color_palette['nord4'], "", "NONE", "", "NONE", "")

	" other interface colors
	call s:hi('SpecialKey', s:color_palette['nord2'], "", "NONE", "", "NONE", "")

	hi! link CursorLineNR CursorLine
	hi! link EndOfBuffer Ignore
	hi! link QuickFixLine CursorLine
endfunction
