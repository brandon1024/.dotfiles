let g:java_import_order = [
	\ { 'static': 1, 'packages': [] },
	\ { 'static': 0, 'packages': ['java.', 'javax.'] },
	\ { 'static': 0, 'packages': [] },
	\ { 'static': 0, 'packages': ['com.emeter.', 'com.siemens.'] }]

nnoremap <silent> <leader>jo :JavaImportSort<CR>
nnoremap <silent> <leader>ji :JavaImportKeyword<CR>
nnoremap <silent> <C-i> :JavaImportKeyword<CR>
nnoremap <silent> <leader>jc :JavaImportIndex<CR>

