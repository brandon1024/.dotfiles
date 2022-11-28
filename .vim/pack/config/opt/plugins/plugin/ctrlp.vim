"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fuzzy Finding (CtrlP)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

packadd! ctrlp

" search from the cwd, not from whatever file happens to be open
let g:ctrlp_working_path_mode = 'w'

" show hidden files (dotfiles)
let g:ctrlp_show_hidden = 1

" enable fuzzy tag lookup extension
let g:ctrlp_extensions = ['tag']

" add a small delay to make plugin more responsive
let g:ctrlp_lazy_update = 150

" backspace on empty prompt closes window
let g:ctrlp_brief_prompt = 1

" configure statuslines
let g:ctrlp_status_func = {
	\ 'main': 'ctrlp#theme#statusline_main',
	\ 'prog': 'ctrlp#theme#statusline_progress',
\ }

" open ctrlp window with CTRL+Space
let g:ctrlp_map = '<C-@>'

" in ctrlp prompt, CTRL+Space to switch modes
let g:ctrlp_prompt_mappings = {
	\ 'ToggleType(1)': ['<C-f>', '<C-@>'],
\ }

