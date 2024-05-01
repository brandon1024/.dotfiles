"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimwiki Plugin Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

packadd! vimwiki

let g:vimwiki_list = [{'path': '~/.local/share/vimwiki',
	\ 'syntax': 'markdown', 'ext': 'md'}]

let g:vimwiki_key_mappings = { 'all_maps': 0, }

nnoremap <silent> <leader>ww <Plug>VimwikiIndex

augroup vimwiki_autocmd_group
	autocmd!
	autocmd FileType vimwiki call vimwiki#mappings#init()
augroup END
