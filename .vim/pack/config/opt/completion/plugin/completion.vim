"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Automatic Text Completion Configuration and Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set completeopt=menuone,noinsert,popup
set complete=.,w,b,u,t
set shortmess+=c
set infercase

" tab to select completion
inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"

" enter closes completion menu
inoremap <silent> <expr> <CR> pumvisible() ? "\<C-e>\<CR>" : "\<CR>"

" show completion as you type
augroup completion_prompt_autocmd_group
	autocmd!
	autocmd InsertCharPre * call completion#complete()
augroup END

