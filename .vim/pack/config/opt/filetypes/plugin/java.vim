let g:java_import_order = [
	\ { 'static': 1, 'packages': [] },
	\ { 'static': 0, 'packages': ['java.', 'javax.'] },
	\ { 'static': 0, 'packages': [] },
	\ { 'static': 0, 'packages': ['com.emeter.', 'com.siemens.'] }]

nnoremap <silent> <leader>o :JavaSortImports<CR>
nnoremap <silent> <leader>i :JavaImportKeyword<CR>
nnoremap <silent> <leader>c :JavaIndexImports<CR>

