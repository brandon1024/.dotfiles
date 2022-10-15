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

function! s:AutoComplete()
	" quickly return if there's nothing to do
	if v:char !~ '\K'
		return
	endif

	let l:linetocursor = getline('.')[:col('.')-2] . v:char

	" Vim occasionally freezes when showing the Completion menu. A
	" workaround is to apply a miniscule delay to feedkeys, as described
	" in this issue: https://github.com/vim/vim/issues/4572

	if l:linetocursor =~ '\K\{4,}$'
		" If last four characters are keyword chars, show full complete menu
		" (results from 'complete')
		call timer_start(0, { ->
				\ feedkeys((pumvisible() ? "\<C-e>" : "") . "\<C-n>", 'n') })
	elseif l:linetocursor =~ '\K\{2,}$'
		" If last three characters are keyword chars, show partial complete
		" menu (keywords in current file).
		call timer_start(0, { ->
				\ feedkeys((pumvisible() ? "\<C-e>" : "") . "\<C-x>\<C-n>", 'n') })
	end
endfunction

" show completion as you type
augroup completion_prompt_autocmd_group
	autocmd!
	autocmd InsertCharPre * call s:AutoComplete()
augroup END

