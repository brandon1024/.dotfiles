let g:java_import_order = [
	\ { 'static': 1, 'packages': [] },
	\ { 'static': 0, 'packages': ['java.', 'javax.'] },
	\ { 'static': 0, 'packages': [] },
	\ { 'static': 0, 'packages': ['com.emeter.', 'com.siemens.'] }]

nnoremap <silent> <C-i> :Java import<CR>
nnoremap <silent> <F6> :Java imports optimize<CR>
nnoremap <silent> <leader>jc :Java index<CR>
nnoremap <silent> <F5> :Java insert-var<CR>
inoremap <silent> <F5> <C-o>:Java insert-var<CR>

