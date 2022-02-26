"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Configure Tabline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! TablineCurrentTabGenerate(tabnum)
	let l:blue = '%#StatuslineBlueBg#'
	let l:dark1 = '%#StatuslineDarkBg#'

	" There's an upstream bug, fixed in a493b6506 (patch 8.2.4419: illegal
	" memory access when using 20 highlights, 2022-02-19),
	" that causes Vim to crash whenever there are too many highlights in the
	" tabline. If we don't have this patch, don't bother highlighting anything
	" aside from the current tab/buffer.
	let l:dark2 = has('patch-8.2.4419') ? '%#StatuslineDarkerBg#' : ''

	let l:format = l:dark1 . ' ' . l:blue . ' ‹' . a:tabnum . '› ' . l:dark1
	let l:buffers = getbufinfo({'buflisted': 1, 'windows': gettabinfo(a:tabnum)})

	for b in l:buffers
		let l:bname = b['name'] ?? 'empty'
		let l:bname = fnamemodify(l:bname, ':t')

		if b['bufnr'] == bufnr('%')
			let l:format .= ' ' . l:blue . ' ' . b['bufnr'] . ' ' . l:bname . ' ' . l:dark1
		else
			let l:format .= ' ' . l:dark2 . ' ' . b['bufnr'] . ' ' . l:bname . ' ' . l:dark1
		endif
	endfor

	return l:format
endfunction

function! TablineHiddenTabGenerate(tabnum)
	return '%#StatuslineDarkBg# %#StatuslineDarkerBg# ‹' . a:tabnum . '› %#StatuslineDarkBg#'
endfunction

function! TablineGenerate()
	let l:tabline = '%#StatuslineDarkBg# ⋰ '
	let l:tabcount = tabpagenr('$')

	for i in range(l:tabcount)
		if i + 1 == tabpagenr()
			let l:tabline .= TablineCurrentTabGenerate(i)
		else
			let l:tabline .= TablineHiddenTabGenerate(i)
		endif
	endfor

	return l:tabline
endfunction

" format the tabline
set showtabline=2
set tabline=%!TablineGenerate()

