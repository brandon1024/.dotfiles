"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Configure Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:to_color(name)
	return '%#' . a:name . '#'
endfunction

function! s:color_or_inactive(name)
	return g:statusline_winid == win_getid() ?
			\ s:to_color(a:name) : s:to_color('StatuslineLightBg')
endfunction

function! s:format_content(color, content)
	return s:color_or_inactive(a:color) . ' ' . a:content . ' '
endfunction

function! s:mode_segment()
	let l:modemap = {
		\ 'n': {'v': 'NORMAL', 'c': 'StatuslineBlueBg'},
		\ 'i': {'v': 'INSERT', 'c': 'StatuslinePinkBg'},
		\ 'R': {'v': 'RPLACE', 'c': 'StatuslineTealBg'},
		\ 'v': {'v': 'V CHAR', 'c': 'StatuslineOrngBg'},
		\ 'V': {'v': 'V LINE', 'c': 'StatuslineOrngBg'},
		\ '\<C-V>': {'v': 'VBLOCK', 'c': 'StatuslineOrngBg'},
		\ 't': {'v': ' TERM ', 'c': 'StatuslineDarkerBg'}
	\ }
	let l:modemapdefault = {'v': mode(), 'c': 'StatuslineDarkerBg'}

	let l:modedata = get(l:modemap, mode()[0:1], l:modemapdefault)
	let l:format =
			\ s:format_content(l:modedata['c'], l:modedata['v']) .
			\ s:color_or_inactive('StatuslineDarkBg') .
			\ (&paste ? ' PASTE │' : '') .
			\ (&readonly ? ' %R │' : '') .
			\ ' %n │ %t ' .
			\ s:to_color('StatuslineDarkBg')
	
	return l:format
endfunction

function! s:file_info_segment()
	let l:ContentNS = { color, content -> s:color_or_inactive(color) . content }
	let l:Content = { color, content -> l:ContentNS(color, ' ' . content . ' ') }

	let l:format =
			\ l:Content('StatuslineLightBg',
				\ (&fileencoding ? &fileencoding : &encoding) . ' [' . &fileformat . ']') .
			\ l:Content('StatuslineOrngBg', '%p%% ≣') .
			\ l:Content('StatuslineOrngBg', '%l:%c')

	return l:format
endfunction

function! StatuslineGenerate()
	let l:sl = s:mode_segment()
	let l:sl .= '%='
	let l:sl .= s:file_info_segment()
	
	return l:sl
endfunction

" format the status line
set statusline=%!StatuslineGenerate()

