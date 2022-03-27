if exists('g:loaded_filetypes_java_plugin')
	finish
endif
let g:loaded_filetypes_java_plugin = 1

" The default order for java imports.
"
" Each entry represents a group of sorted imports, where entries are
" dictionaries with the following keys:
" 	static: 1 indicates that this group is for static imports
" 	packages: an array of packages to include in this group
"
" If `packages` is empty, matches anything.
if !exists('g:java_import_order')
	let g:java_import_order = [
		\ { 'static': 1, 'packages': [] },
		\ { 'static': 0, 'packages': ['java.', 'javax.'] },
		\ { 'static': 0, 'packages': [] },
		\ { 'static': 0, 'packages': ['com.emeter.', 'com.siemens.'] }]
endif

" By default, don't insert space between import groups.
if !exists('g:java_import_space_group')
	let g:java_import_space_group = 1
endif

command JavaSortImports call java#JavaSortImports()

nnoremap <silent> <leader>o :call JavaSortImports()<CR>

