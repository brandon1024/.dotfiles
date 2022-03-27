" Starting at line number `lnum`, find the first line matching pattern `patt`,
" returning the line number. Return 0 if no such line could be found.
function! s:FindLineMatchingPattern(lnum, patt) abort
	let l:idx = a:lnum
	while l:idx <= line('$')
		if match(getline(l:idx), a:patt) >= 0
			return l:idx
		endif

		let l:idx += 1
	endwhile

	return 0
endfunction

" Return a list of import statements from the current buffer.
" The import statements are removed from the buffer.
function! s:FilterImportStatementsFromBuffer() abort
	let l:imports = []
	let l:idx = 1
	while l:idx > 0
		let l:idx = s:FindLineMatchingPattern(l:idx, '^import\s.\+;$')
		if l:idx
			call add(l:imports, getline(l:idx))
			call deletebufline('%', l:idx)
		endif
	endwhile

	return l:imports
endfunction

" Starting from line number `lnum`, remove all lines matching the pattern
" `trunc_patt` until a line matching `stop_patt` is encountered.
" Return the line number matching `stop_patt`, or 0 if pattern not found.
function! s:TruncateToPattern(lnum, trunc_patt, stop_patt) abort
	let l:idx = a:lnum
	for l in getline(l:idx, line('$'))
		if match(l, a:stop_patt) >= 0
			return l:idx
		endif

		if match(l, a:trunc_patt) >= 0
			call deletebufline('%', a:lnum)
		else
			let a:lnum += 1
		endif
	endfor

	return 0
endfunction

" Create and return sorted list of import statements.
" Each entry in `imports` must have the following format:
" 	^import\s(static\s)?.+
"
" Returns the group of statements.
function! s:CreateImportStatementGroup(imports, packages) abort
	let l:grp = []

	for stmt in a:imports
		" split import statment into parts
		let l:parts = split(stmt)

		" validate
		if !len(l:parts) || len(l:parts) > 3
			echoerr 'bug: unexpected number of parts to statment "' . stmt . '"'
		elseif l:parts[0] != 'import'
			echoerr 'bug: expected import keyword in statment "' . stmt . '"'
		elseif len(l:parts) == 3 && l:parts[1] != 'static'
			echoerr 'bug: malformed statement "' . stmt . '"'
		endif

		" try to match against `packages`
		let l:import_pkg = l:parts[-1]
		for package in a:packages
			if stridx(l:import_pkg, package) == 0
				call add(l:grp, stmt)
				break
			endif
		endfor
	endfor

	return sort(l:grp)
endfunction

" Flatten the groups into a single list. If `g:java_import_space_group` is
" true, groups are separated by an empty space.
function! s:FlattenGroups(groups) abort
	call filter(a:groups, { idx, val -> len(val) })

	if g:java_import_space_group
		for idx in range(len(a:groups) - 1)
			call add(a:groups[idx], '')
		endfor
	endif

	return flatten(a:groups)
endfunction

function! s:ImportPartitionReducer(acc, val) abort
	call add(a:acc[match(a:val, 'import\sstatic\s.\+;') >= 0], a:val)
	return a:acc
endfunction

" Sort `imports` according to `g:java_import_order`.
function! s:SortImportStatements(imports) abort
	" partition imports into static and non-static
	let l:import_stmts = reduce(a:imports,
		\ function('s:ImportPartitionReducer'), [[],[]])

	" group statments according to configuration
	let l:import_stmt_grps = []
	for group in g:java_import_order
		let l:is_static_group = has_key(group, 'static') && group['static']
		let l:grp = s:CreateImportStatementGroup(
			\ l:import_stmts[l:is_static_group ? 1 : 0], group['packages'])

		" filter statements
		call filter(l:import_stmts[l:is_static_group ? 1 : 0],
			\ { idx, val -> index(l:grp, val) < 0 })

		call add(l:import_stmt_grps, l:grp)
	endfor

	" second pass for any remaining imports
	for idx in range(len(g:java_import_order))
		let l:group = g:java_import_order[idx]
		let l:is_static_group = has_key(group, 'static') && group['static']

		if !len(l:group['packages'])
			call extend(l:import_stmt_grps[idx],
				\ l:import_stmts[l:is_static_group ? 1 : 0])
			let l:import_stmts[l:is_static_group ? 1 : 0] = []
		endif
	endfor

	" any statements that don't fit into any group are added to the end
	call add(l:import_stmt_grps, flatten(l:import_stmts))

	return s:FlattenGroups(l:import_stmt_grps)
endfunction

" Write out lines from `statements` at line number `lnum`.
function! s:WriteImportStatements(lnum, statements) abort
	for stmt in reverse(flatten(['', a:statements, '']))
		call appendbufline('%', a:lnum, stmt)
	endfor
endfunction

" Sort import statements in the current buffer.
function! java#JavaSortImports() abort
	" ensure this is a java file
	if &filetype != 'java'
		echohl WarningMsg |
			\ echo 'cannot sort imports: unexpected filetype "' . &filetype . '"' |
			\ echohl None
		return
	endif

	" find and remove import statements from buffer
	let l:imports = s:FilterImportStatementsFromBuffer()

	" truncate leading empty lines
	let l:idx = s:TruncateToPattern(1, '^$', '^.')

	" look for package statement and truncate empty lines between package
	" statement and first bit of text
	let l:pkg_stmt_lnum = s:FindLineMatchingPattern(l:idx, '^package\s.\+;$')
	if l:pkg_stmt_lnum > 0
		call s:TruncateToPattern(l:pkg_stmt_lnum + 1, '^$', '^.')
		let l:idx = l:pkg_stmt_lnum
	endif

	" sort import statements according to configuration
	let l:imports = s:SortImportStatements(l:imports)

	" write sorted import statements
	call s:WriteImportStatements(l:idx, l:imports)
endfunction

