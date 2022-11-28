function! ctrlp#theme#statusline_main(focus, byfname, regex, prev, item, next, marked) abort
	return ui#segment#render([
		\ ui#segment#new('  CTRLP ', 'StatuslineBlueBg'),
		\ ui#segment#spacer('StatuslineDarkerBg'),
		\ ui#segment#new(' ' . a:byfname . ' ', 'StatuslineDarkBg'),
		\ ui#segment#new(' [' . a:item . '] ', 'StatuslineDarkBg'),
		\ ui#segment#justify('StatuslineDarkBg'),
		\ ui#segment#new(' ' . getcwd() . ' ', 'StatuslineLightBg')
	\ ])
endfunction

function! ctrlp#theme#statusline_progress(str) abort
	return ui#segment#render([
		\ ui#segment#new('  CTRLP ', 'StatuslineBlueBg'),
		\ ui#segment#spacer('StatuslineDarkerBg'),
		\ ui#segment#new(' scanning [' . a:str . '] ', 'StatuslineLightBg'),
		\ ui#segment#justify('StatuslineDarkBg'),
		\ ui#segment#new(' ' . getcwd() . ' ', 'StatuslineLightBg')
	\ ])
endfunction
