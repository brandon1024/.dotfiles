vim9script

###############################################################
# => Automatic Text Completion
###############################################################

# Autocomplete a word in insert mode. Intended to be executed in an
# InsertCharPre event.
export def Complete()
	# quickly return if there's nothing to do
	if v:char !~ '\K'
		return
	endif

	var linetocursor = getline('.')[: col('.') - 2] .. v:char

	# Vim occasionally freezes when showing the Completion menu. A
	# workaround is to apply a miniscule delay to feedkeys, as described
	# in this issue: https://github.com/vim/vim/issues/4572

	if linetocursor =~ '\K\{4,}$'
		# If last four characters are keyword chars, show full complete menu
		# (results from 'complete')
		# timer_start(0, (_) => feedkeys((InCompletion() ? "\<C-e>" : "") .. "\<C-n>", 'n'))
		feedkeys((InCompletion() ? "\<C-e>" : "") .. "\<C-n>", 'n')
	elseif linetocursor =~ '\K\{3,}$'
		# If last three characters are keyword chars, show partial complete
		# menu (keywords in current file) to improve performance.
		# timer_start(0, (_) => feedkeys((InCompletion() ? "\<C-e>" : "") .. "\<C-x>\<C-n>", 'n'))
		feedkeys((InCompletion() ? "\<C-e>" : "") .. "\<C-x>\<C-n>", 'n')
	endif
enddef

# Check if currently in insert mode completion.
def InCompletion(): bool
	return !empty(complete_info(['mode'])['mode'])
enddef
