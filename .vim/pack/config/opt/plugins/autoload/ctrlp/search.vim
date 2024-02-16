function! ctrlp#search#fuzzy(items, pat, limit, mmode, ispath, exc, regex)
	if empty(a:pat)
		return items[:a:limit]
	endif

	if a:regex
		return filter(a:items, {idx, val -> val =~ a:pat})
	endif

	return reverse(matchfuzzy(a:items, a:pat, {
		\ "limit": a:limit,
	\ }))
endfunction
