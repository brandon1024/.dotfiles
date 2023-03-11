"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" add onedark plugin and set colorscheme
packadd! onedark
colorscheme onedark

" enable true colors
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" configure highlight colours
highlight StatuslineBlueBg    ctermfg=15 ctermbg=25  guibg=#61AFEF guifg=#282C34
highlight StatuslineDarkBg    ctermfg=15 ctermbg=236 guibg=#2C323C guifg=#ABB2BF
highlight StatuslineDarkerBg  ctermfg=15 ctermbg=237 guibg=#282C34 guifg=#ABB2BF
highlight StatuslineLightBg   ctermfg=15 ctermbg=235 guibg=#363D49 guifg=#ABB2BF
highlight StatuslineLighterBg ctermfg=15 ctermbg=235 guibg=#576175 guifg=#ABB2BF
highlight StatuslineOrngBg    ctermfg=0  ctermbg=208 guibg=#FF8A1C guifg=#282C34
highlight StatuslinePinkBg    ctermfg=15 ctermbg=132 guibg=#CB93DB guifg=#282C34
highlight StatuslinePurpleBg  ctermfg=15 ctermbg=54  guibg=#C678DD guifg=#282C34
highlight StatuslineTealBg    ctermfg=15 ctermbg=73  guibg=#56B6C2 guifg=#282C34

highlight StatuslineBlueFg    ctermfg=25  ctermbg=NONE guifg=#61AFEF guibg=NONE
highlight StatuslineDarkFg    ctermfg=236 ctermbg=NONE guifg=#2C323C guibg=NONE
highlight StatuslineGreenFg   ctermfg=34  ctermbg=NONE guifg=#98C379 guibg=NONE
highlight StatuslineLightFg   ctermfg=235 ctermbg=NONE guifg=#363D49 guibg=NONE
highlight StatuslineLighterFg ctermfg=235 ctermbg=NONE guifg=#576175 guibg=NONE
highlight StatuslineOrngFg    ctermfg=208 ctermbg=NONE guifg=#FF8A1C guibg=NONE
highlight StatuslinePinkFg    ctermfg=132 ctermbg=NONE guifg=#CB93DB guibg=NONE
highlight StatuslinePurpleFg  ctermfg=54  ctermbg=NONE guifg=#C678DD guibg=NONE
highlight StatuslineRedFg     ctermfg=124 ctermbg=NONE guifg=#E06C75 guibg=NONE
highlight StatuslineYellowFg  ctermfg=11  ctermbg=NONE guifg=#E5C07B guibg=NONE
highlight StatuslineTealFg    ctermfg=73  ctermbg=NONE guifg=#56B6C2 guibg=NONE

highlight Pmenu               ctermfg=15 ctermbg=235 guibg=#363D49 guifg=#ABB2BF
highlight PmenuThumb          ctermfg=15 ctermbg=235 guibg=#363D49 guifg=#ABB2BF
highlight PmenuSbar           ctermfg=15 ctermbg=236 guibg=#2C323C guifg=#ABB2BF
highlight link                PmenuTextNormal Normal
highlight PmenuTextDark       ctermfg=59 guifg=#5C6370
highlight PmenuTextOrange     ctermfg=180 guifg=#E5C07B
