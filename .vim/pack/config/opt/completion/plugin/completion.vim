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

