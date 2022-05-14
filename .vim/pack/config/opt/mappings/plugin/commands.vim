function! CopySelectionToClipboard(begin, end) abort
	if !has('clipboard')
		echohl WarningMsg |
			\ echo "CopySelection: vim isn't compiled with +clipboard; these features aren't supported" |
			\ echohl None
		return
	endif

	let l:lines = getbufline('%', a:begin, a:end)
	for lnum in range(a:begin, a:end)
		let l:lines[lnum - a:begin] = ' ' . lnum . '  ' . l:lines[lnum - a:begin]
	endfor

	call setreg('+', [expand('%:t')] + l:lines)
endfunction

" for this to work, you'll need vim compiled with +clipboard
" (e.g. installed with 'vim-gtk' in some environments)
command! -range CopySelection call CopySelectionToClipboard(<line1>, <line2>)

