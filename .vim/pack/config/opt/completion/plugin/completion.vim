vim9script

###############################################################
# => Automatic Text Completion Configuration and Mappings
###############################################################

set completeopt=menuone,noinsert,popup,fuzzy
set complete=.^5,w^5,b^5,u^5,t^5
set shortmess+=c
set shortmess+=C
set infercase
set autocomplete
set autocompletedelay=100

# tab to select completion
inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent> <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
