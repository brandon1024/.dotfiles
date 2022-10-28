"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => java-support Plugin Configuration and Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

packadd! java-support.vim

let g:java_import_order = [
	\ { 'static': 1, 'packages': [] },
	\ { 'static': 0, 'packages': ['java.', 'javax.'] },
	\ { 'static': 0, 'packages': [] },
	\ { 'static': 0, 'packages': ['com.emeter.', 'com.siemens.'] }]

function! s:InitJava() abort
	nnoremap <silent> <buffer> <C-i> :Java import<CR>
	nnoremap <silent> <buffer> <F6> :Java imports optimize<CR>
	nnoremap <silent> <buffer> <leader>jc :Java index<CR>
	nnoremap <silent> <buffer> <F5> :Java insert-var<CR>
	inoremap <silent> <buffer> <F5> <C-o>:Java insert-var<CR>

	nnoremap <silent> <buffer> <C-_> gcc
endfunction

augroup java_support_custom
	autocmd!
	autocmd FileType java call s:InitJava()
augroup END

