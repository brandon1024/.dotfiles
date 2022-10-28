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
highlight StatuslineLightBg  ctermfg=15 ctermbg=235 guibg=#363D49 guifg=#ABB2BF
highlight StatuslineDarkBg   ctermfg=15 ctermbg=236 guibg=#2C323C guifg=#ABB2BF
highlight StatuslineDarkerBg ctermfg=15 ctermbg=237 guibg=#282C34 guifg=#ABB2BF
highlight StatuslineBlueBg   ctermfg=15 ctermbg=25  guibg=#61AFEF guifg=#282C34
highlight StatuslinePinkBg   ctermfg=15 ctermbg=132 guibg=#C678DD guifg=#282C34
highlight StatuslineOrngBg   ctermfg=0  ctermbg=208 guibg=#D19A66 guifg=#282C34
highlight StatuslineTealBg   ctermfg=15 ctermbg=73  guibg=#56B6C2 guifg=#282C34

