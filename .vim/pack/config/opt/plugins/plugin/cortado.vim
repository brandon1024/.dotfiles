"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => java-support Plugin Configuration and Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

packadd! cortado

let g:cortado_import_order = [
	\ { 'static': 1, 'packages': [] },
	\ { 'static': 0, 'packages': ['java.', 'javax.'] },
	\ { 'static': 0, 'packages': [] },
	\ { 'static': 0, 'packages': ['com.emeter.', 'com.siemens.'] }]

augroup cortado_custom
	autocmd!
	autocmd FileType java call cortado#mappings#init()
augroup END

