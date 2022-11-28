"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => java-support Plugin Configuration and Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

packadd! java-support.vim

let g:java_import_order = [
	\ { 'static': 1, 'packages': [] },
	\ { 'static': 0, 'packages': ['java.', 'javax.'] },
	\ { 'static': 0, 'packages': [] },
	\ { 'static': 0, 'packages': ['com.emeter.', 'com.siemens.'] }]

augroup java_support_custom
	autocmd!
	autocmd FileType java call java_support#mappings#init()
augroup END

