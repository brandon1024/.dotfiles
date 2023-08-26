"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" remove background color for transparent terminals
augroup theme_no_background
	autocmd!
	let s:white = { 'gui': '#ABB2BF', 'cterm': '145', 'cterm16' : '7' }
	autocmd ColorScheme * call onedark#set_highlight('Normal', { 'fg': s:white })
augroup END

" add onedark plugin and set colorscheme
packadd! onedark
colorscheme onedark

" enable true colors
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" configure colours
highlight ThemeColorBlueBg    ctermfg=15  ctermbg=25   guibg=#61AFEF guifg=#282C34
highlight ThemeColorBlueFg    ctermfg=25  ctermbg=NONE guifg=#61AFEF guibg=NONE
highlight ThemeColorDarkBg    ctermfg=15  ctermbg=236  guibg=#2C323C guifg=#ABB2BF
highlight ThemeColorDarkFg    ctermfg=236 ctermbg=NONE guifg=#2C323C guibg=NONE
highlight ThemeColorDarkerBg  ctermfg=15  ctermbg=237  guibg=#282C34 guifg=#ABB2BF
highlight ThemeColorDarkerFg  ctermfg=237 ctermbg=NONE guibg=#ABB2BF guifg=NONE
highlight ThemeColorLightBg   ctermfg=15  ctermbg=235  guibg=#363D49 guifg=#ABB2BF
highlight ThemeColorLightFg   ctermfg=235 ctermbg=NONE guifg=#363D49 guibg=NONE
highlight ThemeColorLighterBg ctermfg=15  ctermbg=235  guibg=#576175 guifg=#ABB2BF
highlight ThemeColorLighterFg ctermfg=235 ctermbg=NONE guifg=#576175 guibg=NONE
highlight ThemeColorOrngBg    ctermfg=0   ctermbg=208  guibg=#E5C07B guifg=#282C34
highlight ThemeColorOrngFg    ctermfg=208 ctermbg=NONE guifg=#E5C07B guibg=NONE
highlight ThemeColorPinkBg    ctermfg=15  ctermbg=132  guibg=#CB93DB guifg=#282C34
highlight ThemeColorPinkFg    ctermfg=132 ctermbg=NONE guifg=#CB93DB guibg=NONE
highlight ThemeColorPurpleBg  ctermfg=15  ctermbg=54   guibg=#C678DD guifg=#282C34
highlight ThemeColorPurpleFg  ctermfg=54  ctermbg=NONE guifg=#C678DD guibg=NONE
highlight ThemeColorTealBg    ctermfg=15  ctermbg=73   guibg=#56B6C2 guifg=#282C34
highlight ThemeColorTealFg    ctermfg=73  ctermbg=NONE guifg=#56B6C2 guibg=NONE

highlight ThemeColorRedFg     ctermfg=124 ctermbg=NONE guifg=#E06C75 guibg=NONE
highlight ThemeColorYellowFg  ctermfg=11  ctermbg=NONE guifg=#E5C07B guibg=NONE
highlight ThemeColorGreenFg   ctermfg=34  ctermbg=NONE guifg=#98C379 guibg=NONE

highlight Pmenu               ctermfg=15 ctermbg=235 guibg=#363D49 guifg=#ABB2BF
highlight PmenuThumb          ctermfg=15 ctermbg=235 guibg=#363D49 guifg=#ABB2BF
highlight PmenuSbar           ctermfg=15 ctermbg=236 guibg=#2C323C guifg=#ABB2BF
highlight link                PmenuTextNormal Normal
highlight PmenuTextDark       ctermfg=59 guifg=#5C6370
highlight PmenuTextOrange     ctermfg=180 guifg=#E5C07B

highlight ThemeNormalLight    ctermfg=145 ctermbg=235 guifg=#ABB2BF guibg=#282C34
highlight ThemeNormalDark     ctermfg=145 ctermbg=235 guifg=#ABB2BF guibg=#21252c

