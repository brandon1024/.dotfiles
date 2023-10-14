function! ctrlp#theme#statusline_main(focus, byfname, regex, prev, item, next, marked) abort
	return ui#segment#render([
		\ ui#segment#new('   CTRLP ', 'ThemeStatuslineBackground'),
		\ ui#segment#spacer('ThemeStatuslineBackground'),
		\ ui#segment#new(' ' . a:byfname . ' ', 'ThemeStatuslineBackground'),
		\ ui#segment#new(' [' . a:item . '] ', 'ThemeStatuslineBackground'),
		\ ui#segment#justify('ThemeStatuslineBackground'),
		\ ui#segment#new(' ' . getcwd() . ' ', 'ThemeStatuslineBackground')
	\ ])
endfunction

function! ctrlp#theme#statusline_progress(str) abort
	return ui#segment#render([
		\ ui#segment#new('  CTRLP ', 'ThemeStatuslineBackground'),
		\ ui#segment#spacer('ThemeStatuslineBackground'),
		\ ui#segment#new(' scanning [' . a:str . '] ', 'ThemeStatuslineBackground'),
		\ ui#segment#justify('ThemeStatuslineBackground'),
		\ ui#segment#new(' ' . getcwd() . ' ', 'ThemeStatuslineBackground')
	\ ])
endfunction
