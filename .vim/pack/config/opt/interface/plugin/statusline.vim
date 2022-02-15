"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Configure Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! StatuslineGenerateModeSegment()
	let l:ToColor = { name -> "%#" . name . "#" }
	let l:Content = { color, content -> l:ToColor(color) . " " . content . " " }

	let l:modemap = {
		\ "n": {"v": "NORMAL", "c": "StatuslineBlueBg"},
		\ "i": {"v": "INSERT", "c": "StatuslinePinkBg"},
		\ "R": {"v": "RPLACE", "c": "StatuslineTealBg"},
		\ "v": {"v": "V CHAR", "c": "StatuslineOrngBg"},
		\ "V": {"v": "V LINE", "c": "StatuslineOrngBg"},
		\ "\<C-V>": {"v": "VBLOCK", "c": "StatuslineOrngBg"},
		\ "t": {"v": " TERM ", "c": "StatuslineDarkerBg"}
	\ }
	let l:modemapdefault = {"v": mode(), "c": "StatuslineDarkerBg"}

	let l:modedata = get(l:modemap, mode()[0:1], l:modemapdefault)
	let l:format =
			\ l:Content(l:modedata["c"], l:modedata["v"]) .
			\ l:ToColor("StatuslineDarkBg") .
			\ (&paste ? " PASTE │" : "") .
			\ (&readonly ? " %R │" : "") .
			\ " %n │ %t "
	
	return l:format
endfunction

function! StatuslineGenerateFileInfoSegment()
	let l:ToColor = { name -> "%#" . name . "#" }
	let l:ContentNS = { color, content -> l:ToColor(color) . content }
	let l:Content = { color, content -> l:ContentNS(color, " " . content . " ") }

	let l:format =
			\ l:Content("StatuslineOrngBg",
				\ (&fileencoding ? &fileencoding : &encoding) . " [" . &fileformat . "]") .
			\ l:ContentNS("StatuslineDarkBg", " ") .
			\ l:Content("StatuslineOrngBg", "%p%%") .
			\ l:ContentNS("StatuslineDarkBg", " ") .
			\ l:Content("StatuslineOrngBg", "%l:%c")

	return l:format
endfunction

function! StatuslineGenerate()
	let l:sl = StatuslineGenerateModeSegment()
	let l:sl .= "%="
	let l:sl .= StatuslineGenerateFileInfoSegment()
	
	return l:sl
endfunction

" format the status line
set statusline=%!StatuslineGenerate()

