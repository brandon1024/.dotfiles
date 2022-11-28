"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Automatic Text Completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Autocomplete a word in insert mode. Intended to be executed in an
" InsertCharPre event.
function! completion#complete()
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
				\ feedkeys((s:in_completion() ? "\<C-e>" : "") . "\<C-n>", 'n') })
	elseif l:linetocursor =~ '\K\{2,}$'
		" If last three characters are keyword chars, show partial complete
		" menu (keywords in current file).
		call timer_start(0, { ->
				\ feedkeys((s:in_completion() ? "\<C-e>" : "") . "\<C-x>\<C-n>", 'n') })
	end
endfunction

" Check if currently in insert mode completion.
function! s:in_completion() abort
	return !empty(complete_info(['mode'])['mode'])
endfunction
