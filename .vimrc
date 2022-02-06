"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" configure history
set history=500

" enable filetype plugins
filetype plugin on

" set to auto read when a file is changed from the outside
set autoread

" configure search path
set path+=**

" ignore case when searching, unless there's an uppercase in search query
set ignorecase smartcase

" navigate to search results as you type
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" enable wiLd menu for easier command completion
set wildmenu

" disable backups and swap files
set nowb noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File Type Configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType java,groovy setlocal expandtab
autocmd FileType gitcommit,gitrebase set nonumber nolist statusline= tabline= showtabline=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'lambdalisue/fern.vim'
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" scrolloff (show 7 lines above/below when navigating a file)
set so=7

" show line numbers
set number relativenumber

" Show matching brackets when text indicator is over them
set showmatch

" enable syntax highlighting
syntax enable

" enable 256 colors palette
set t_Co=256

" set colour scheme
colorscheme slate

" configure color column (line length guide)
set colorcolumn=80
hi ColorColumn ctermbg=236

" configure vertical split column
set fillchars+=vert:│
hi VertSplit ctermbg=237 ctermfg=236

" show tabs and spaces
set list listchars=space:·,tab:──·
hi SpecialKey ctermfg=240

" always show the status line
set laststatus=2

" don't show the mode under statusline
" the mode is already shown in the statusline
set noshowmode

" colors
hi StatuslineDarkBg   ctermfg=15 ctermbg=236
hi StatuslineDarkerBg ctermfg=15 ctermbg=237
hi StatuslineBlueBg   ctermfg=15 ctermbg=25
hi StatuslinePinkBg   ctermfg=15 ctermbg=132
hi StatuslineOrngBg   ctermfg=0 ctermbg=208
hi StatuslineTealBg   ctermfg=15 ctermbg=73


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [normal] tab shortcuts
nnoremap tn :tabnext<Space>
nnoremap tp :tabprev<Space>
nnoremap te :tabe<Space>

" [normal] swtich between buffers
nnoremap bn :bnext
nnoremap bp :bprev

" [insert] indent and de-indent
inoremap <S-Tab> <C-d>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open terminal below all splits
cabbrev bterm bo term
nnoremap <silent> <C-t>b :bo term ++rows=16<CR>
nnoremap <silent> <C-t>r :vert bo term<CR>

" auto configure terminal statusline
augroup terminal_mapping
	autocmd!
	autocmd TerminalWinOpen * setlocal statusline=%#SignColumn# nolist nonumber
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fern File Explorer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fern#default_hidden = 1
let g:fern#renderer#default#leaf_symbol = "   "
let g:fern#renderer#default#collapsed_symbol = " ▶ "
let g:fern#renderer#default#expanded_symbol = " ▼ "

" change color of left gutter
hi SignColumn ctermbg=NONE

nnoremap <silent> <C-e> :Fern . -toggle -drawer -width=50 -reveal=%<CR>

function! s:init_fern() abort
	setlocal statusline=%#StatuslineDarkBg#%=%#StatuslineBlueBg#\ FERN\ 

	" define some useful keymaps
	nmap <buffer> cd <Plug>(fern-action-enter)
	nmap <buffer> <CR> <Plug>(fern-action-open-or-expand)
	nmap <buffer> l <Plug>(fern-action-open-or-enter)
	nmap <buffer> h <Plug>(fern-action-open:split)
	nmap <buffer> v <Plug>(fern-action-open:vsplit)
endfunction

augroup fern-custom
	autocmd!
	autocmd FileType fern setlocal norelativenumber nonumber | call s:init_fern()
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Indentation and Line Breaks
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" slightly more ergonomic tabs
set smarttab

" tabs have a width of 4 spaces instead of 8
set shiftwidth=4 tabstop=4

" break long lines at specific characters in 'breakat'
set lbr

" enable auto ident
set ai


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Configure Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! StatuslineGenerateModeSegment()
	let l:ToColor = { name -> "%#" . name . "#" }
	let l:Content = { color, content -> l:ToColor(color) . ' ' . content . ' ' }

	let l:modemap = {
		\ 'n': {'v': 'NORMAL', 'c': 'StatuslineBlueBg'},
		\ 'i': {'v': 'INSERT', 'c': 'StatuslinePinkBg'},
		\ 'R': {'v': 'RPLACE', 'c': 'StatuslineTealBg'},
		\ 'v': {'v': 'VISUAL', 'c': 'StatuslineOrngBg'},
		\ 't': {'v': ' TERM ', 'c': 'StatuslineDarkerBg'}
	\ }
	let l:modemapdefault = {'v': mode(), 'c': 'StatuslineDarkerBg'}

	let l:modedata = get(l:modemap, mode()[0:1], l:modemapdefault)
	let l:format =
			\ l:Content(l:modedata['c'], l:modedata['v']) .
			\ l:ToColor('StatuslineDarkBg') .
			\ (&paste ? ' PASTE │' : '') .
			\ (&readonly ? ' %R │' : '') .
			\ ' %n │ %t '
	
	return l:format
endfunction

function! StatuslineGenerateFileInfoSegment()
	let l:ToColor = { name -> "%#" . name . "#" }
	let l:ContentNS = { color, content -> l:ToColor(color) . content }
	let l:Content = { color, content -> l:ContentNS(color, ' ' . content . ' ') }

	let l:format =
			\ l:Content('StatuslineOrngBg',
				\ (&fileencoding ? &fileencoding : &encoding) . ' [' . &fileformat . ']') .
			\ l:ContentNS('StatuslineOrngBg', '│') .
			\ l:Content('StatuslineOrngBg', '%p%%') .
			\ l:ContentNS('StatuslineOrngBg', '│') .
			\ l:Content('StatuslineOrngBg', '%l:%c')

	return l:format
endfunction

function! StatuslineGenerate()
	let l:sl = StatuslineGenerateModeSegment()
	let l:sl .= "%="
	let l:sl .= StatuslineGenerateFileInfoSegment()
	
	return l:sl
endfunction

" format the status line
set statusline=%!StatuslineGenerate()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Configure Tabline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! TablineCurrentTabGenerate(tabnum)
	let l:blue = '%#StatuslineBlueBg#'
	let l:dark1 = '%#StatuslineDarkBg#'
	let l:dark2 = '%#StatuslineDarkerBg#'

	let l:format = l:dark1 . ' ' . l:blue . ' ‹' . a:tabnum . '› ' . l:dark1 . ' '
	let l:buffers = getbufinfo({'buflisted': 1, 'windows': gettabinfo(a:tabnum)})

	for b in l:buffers
		let l:bname = b['name'] ?? 'empty'
		if b['bufnr'] == bufnr('%')
			let l:format .= l:blue . ' ' . l:bname . ' ' . l:dark1
		else
			let l:format .= l:dark2 . ' ' . l:bname . ' ' . l:dark1
		endif
	endfor

	return l:format
endfunction

function! TablineTabHiddenGenerate(tabnum)
	return '%#StatuslineDarkBg# %#StatuslineDarkerBg# ‹' . a:tabnum . '› %#StatuslineDarkBg#'
endfunction

function! TablineGenerate()
	let l:tabline = '%#StatuslineDarkBg# ⋰ '
	let l:tabcount = tabpagenr('$')

	for i in range(l:tabcount)
		if i + 1 == tabpagenr()
			let l:tabline .= TablineCurrentTabGenerate(i)
		else
			let l:tabline .= TablineTabHiddenGenerate(i)
		endif
	endfor

	return l:tabline
endfunction

" format the tabline
set showtabline=2
set tabline=%!TablineGenerate()

