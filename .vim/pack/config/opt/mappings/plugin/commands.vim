"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:CopySelectionToClipboard(begin, end, bang) abort
	if !has('clipboard')
		echohl WarningMsg |
			\ echo "CopySelection: vim isn't compiled with +clipboard; these features aren't supported" |
			\ echohl None
		return
	endif

	let l:lines = getbufline('%', a:begin, a:end)
	if !a:bang
		for lnum in range(a:begin, a:end)
			let l:lines[lnum - a:begin] = ' ' . lnum . '  ' . l:lines[lnum - a:begin]
		endfor

		let l:lines = [expand('%:t')] + l:lines
	endif

	call setreg('+', l:lines)
endfunction

" for this to work, you'll need vim compiled with +clipboard
" (e.g. installed with 'vim-gtk' in some environments)
command! -range -bang CopySelection call <SID>CopySelectionToClipboard(<line1>, <line2>, <bang>v:false)

