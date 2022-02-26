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
		" Vim occasionally freezes when showing the Completion menu. A
		" workaround is to apply a miniscule delay to feedkeys, as described
		" in this issue: https://github.com/vim/vim/issues/4572
		call timer_start(0, { ->
				\ feedkeys((pumvisible() ? "\<C-e>" : "") . "\<C-n>", 'n') })
	end
endfunction

