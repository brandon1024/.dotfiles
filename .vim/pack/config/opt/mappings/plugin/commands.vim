function! CopySelectionToClipboard(line1, line2) abort
	if !has('clipboard')
		echohl WarningMsg |
			\ echo "CopySelection: vim isn't compiled with +clipboard; these features aren't supported" |
			\ echohl None
		return
	endif

	let l:lines = getbufline('%', a:line1, a:line2)
	for idx in range(a:line1, a:line2)
		let l:lines[idx - a:line1] = idx . '  ' . l:lines[idx - a:line1]
	endfor

	let l:lines = [expand('%:t')] + l:lines
	call setreg('+', l:lines)
endfunction

" for this to work, you'll need vim compiled with +clipboard
" (e.g. installed with 'vim-gtk' in some environments)
command! -range CopySelection call CopySelectionToClipboard(<line1>, <line2>)

