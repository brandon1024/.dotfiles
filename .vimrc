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
set wildmode=longest,list,full
set wildignore=*.so,*.o,*.class

" disable backups and swap files
set nowb noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File Type Configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType java,groovy setlocal expandtab
autocmd FileType gitcommit,gitrebase set nonumber norelativenumber nolist statusline= tabline= showtabline=1 colorcolumn=140


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

" enable true colors
set termguicolors
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"

" add onedark plugin and set colorscheme
packadd! onedark
colorscheme onedark

" configure color column (line length guide)
set colorcolumn=80

" configure vertical split column
set fillchars+=vert:│

" show tabs and spaces
set list listchars=space:·,tab:──·

" always show the status line
set laststatus=2

" don't show the mode under statusline
" the mode is already shown in the statusline
set noshowmode

" show cursor line in different color
set cul

" use bar instead of blocking block while in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" colors
hi StatuslineDarkBg   ctermfg=15 ctermbg=236 guibg=#2C323C guifg=#ABB2BF
hi StatuslineDarkerBg ctermfg=15 ctermbg=237 guibg=#282C34 guifg=#ABB2BF
hi StatuslineBlueBg   ctermfg=15 ctermbg=25  guibg=#61AFEF guifg=#282C34
hi StatuslinePinkBg   ctermfg=15 ctermbg=132 guibg=#C678DD guifg=#282C34
hi StatuslineOrngBg   ctermfg=0  ctermbg=208 guibg=#D19A66 guifg=#282C34
hi StatuslineTealBg   ctermfg=15 ctermbg=73  guibg=#56B6C2 guifg=#282C34


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [normal] tab shortcuts
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprev<CR>
nnoremap <leader>te :tabe<Space>

" [normal] swtich between buffers
nnoremap <leader>m :bnext<CR>
nnoremap <leader>n :bprev<CR>

" [insert] indent and de-indent
inoremap <S-Tab> <C-d>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt=menuone,noinsert
set complete=.,w,b,u,t
set shortmess+=c

" tab to select completion
inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"

" enter closes completion menu
inoremap <silent> <expr> <CR> pumvisible() ? "\<C-e>\<CR>" : "\<CR>"

" show completion as you type
autocmd InsertCharPre * call s:AutoComplete()
function! s:AutoComplete()
	" quickly return if there's nothing to do
	if v:char !~ '\K'
		return
	endif

	" if last three characters are keyword chars, show complete menu
	let l:linetocursor = getline('.')[0:col('.')-1]
	if l:linetocursor =~ '\K\{3}$'
		call feedkeys((pumvisible() ? "\<C-e>" : "") . "\<C-n>", 'n')
	end
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open terminal (docked)
nnoremap <silent> <leader>td :bo term ++rows=16<CR>

" open terminal (vertical split)
nnoremap <silent> <leader>tv :vert bo term<CR>

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

nnoremap <silent> <C-e> :Fern . -toggle -drawer -width=50 -reveal=%<CR>

function! s:init_fern() abort
	setlocal statusline=%#StatuslineDarkBg#%=%#StatuslineBlueBg#\ FERN\ 

	" define some useful keymaps
	nmap <buffer> cd <Plug>(fern-action-enter)
	nmap <buffer> l <Plug>(fern-action-open-or-enter)
	nmap <buffer> h <Plug>(fern-action-open:split)
	nmap <buffer> v <Plug>(fern-action-open:vsplit)

	nmap <buffer><expr>
		\ <Plug>(fern-action-toggle-expand-open)
		\ fern#smart#leaf(
		\   "<Plug>(fern-action-open)",
		\   "<Plug>(fern-action-expand)",
		\   "<Plug>(fern-action-collapse)")
	nmap <buffer> <CR> <Plug>(fern-action-toggle-expand-open)
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
	let l:Content = { color, content -> l:ToColor(color) . " " . content . " " }

	let l:modemap = {
		\ "n": {"v": "NORMAL", "c": "StatuslineBlueBg"},
		\ "i": {"v": "INSERT", "c": "StatuslinePinkBg"},
		\ "R": {"v": "RPLACE", "c": "StatuslineTealBg"},
		\ "v": {"v": "V CHAR", "c": "StatuslineOrngBg"},
		\ "V": {"v": "V LINE", "c": "StatuslineOrngBg"},
		\ "\<C-V>": {"v": "VBLOCK", "c": "StatuslineOrngBg"},
		\ "t": {"v": " TERM ", "c": "StatuslineDarkerBg"}
	\ }
	let l:modemapdefault = {"v": mode(), "c": "StatuslineDarkerBg"}

	let l:modedata = get(l:modemap, mode()[0:1], l:modemapdefault)
	let l:format =
			\ l:Content(l:modedata["c"], l:modedata["v"]) .
			\ l:ToColor("StatuslineDarkBg") .
			\ (&paste ? " PASTE │" : "") .
			\ (&readonly ? " %R │" : "") .
			\ " %n │ %t "
	
	return l:format
endfunction

function! StatuslineGenerateFileInfoSegment()
	let l:ToColor = { name -> "%#" . name . "#" }
	let l:ContentNS = { color, content -> l:ToColor(color) . content }
	let l:Content = { color, content -> l:ContentNS(color, " " . content . " ") }

	let l:format =
			\ l:Content("StatuslineOrngBg",
				\ (&fileencoding ? &fileencoding : &encoding) . " [" . &fileformat . "]") .
			\ l:ContentNS("StatuslineDarkBg", " ") .
			\ l:Content("StatuslineOrngBg", "%p%%") .
			\ l:ContentNS("StatuslineDarkBg", " ") .
			\ l:Content("StatuslineOrngBg", "%l:%c")

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
	let l:blue = "%#StatuslineBlueBg#"
	let l:dark1 = "%#StatuslineDarkBg#"
	let l:dark2 = "%#StatuslineDarkerBg#"

	let l:format = l:dark1 . " " . l:blue . " ‹" . a:tabnum . "› " . l:dark1
	let l:buffers = getbufinfo({"buflisted": 1, "windows": gettabinfo(a:tabnum)})

	for b in l:buffers
		let l:bname = b["name"] ?? "empty"
		let l:bname = fnamemodify(l:bname, ":t")
		if b["bufnr"] == bufnr("%")
			let l:format .= " " . l:blue . " " . b["bufnr"] . " " . l:bname . " " . l:dark1
		else
			let l:format .= " " . l:dark2 . " " . b["bufnr"] . " " . l:bname . " " . l:dark1
		endif
	endfor

	return l:format
endfunction

function! TablineTabHiddenGenerate(tabnum)
	return "%#StatuslineDarkBg# %#StatuslineDarkerBg# ‹" . a:tabnum . "› %#StatuslineDarkBg#"
endfunction

function! TablineGenerate()
	let l:tabline = "%#StatuslineDarkBg# ⋰ "
	let l:tabcount = tabpagenr("$")

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

