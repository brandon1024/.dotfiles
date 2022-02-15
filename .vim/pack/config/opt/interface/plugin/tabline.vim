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

