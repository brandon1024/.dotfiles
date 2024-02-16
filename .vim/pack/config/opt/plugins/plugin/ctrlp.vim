"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fuzzy Finding (CtrlP)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

packadd! ctrlp

" search from the cwd, not from whatever file happens to be open
let g:ctrlp_working_path_mode = 'w'

" show hidden files (dotfiles)
let g:ctrlp_show_hidden = 1

" filter a bunch of crap
let g:ctrlp_custom_ignore = '\(__pycache__\|.egg-info\|.pytest_cache\|venv\)'

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

" configure line prefix
let g:ctrlp_line_prefix = ' ▶ '

" open ctrlp window with CTRL+Space
let g:ctrlp_map = '<C-@>'

" in ctrlp prompt, CTRL+Space to switch modes
let g:ctrlp_prompt_mappings = {
	\ 'ToggleType(1)': ['<C-f>', '<C-@>'],
\ }

" configure the ctrlp window
let g:ctrlp_buffer_func = {
	\ 'enter': 'ctrlp#window#enter',
	\ 'exit':  'ctrlp#window#exit',
\ }

" configure an improved matching function that orders by closest match
let g:ctrlp_match_func = {
	\ 'match': 'ctrlp#search#fuzzy',
\ }
