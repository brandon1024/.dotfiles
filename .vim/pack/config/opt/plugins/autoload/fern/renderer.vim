let s:Promise = vital#fern#import('Async.Promise')

" Build a custom renderer that extends the default.
function! fern#renderer#new() abort
	return extend(fern#renderer#default#new(), {
		\ 'render': funcref('s:render'),
	\ })
endfunction

function! s:render_node(name, status, depth) abort
	let l:leading = repeat(g:fern#renderer#default#leading, max([0, a:depth - 1]))

	if a:depth == 0
		let l:symbol = g:fern#renderer#default#root_symbol
	elseif a:status == g:fern#STATUS_NONE
		let l:symbol = g:fern#renderer#default#leaf_symbol
	elseif a:status == g:fern#STATUS_COLLAPSED
		let l:symbol = g:fern#renderer#default#collapsed_symbol
	elseif a:status == g:fern#STATUS_EXPANDED
		let l:symbol = g:fern#renderer#default#expanded_symbol
	endif

	return l:leading . l:symbol . a:name . ''
endfunction

function! s:render_children(children, helper, rendered_nodes) abort
	if empty(a:children)
		return s:Promise.resolve()
	endif

	if len(a:children) == 1
		" collapse
	endif

	" otherwise, render each child and recurse
endfunction

function! s:render(_) abort
	let l:helper = fern#helper#new()
	let l:root_node = l:helper.sync.get_root_node()

	let l:rendered_nodes = [
		\ { 'node': l:root_node, 'name': l:root_node.label, 'depth': 0 }
	\ ]

endfunction

function! s:index(lnum) abort
	return a:lnum - 1
endfunction

function! s:lnum(index) abort
	return a:index + 1
endfunction

function! s:get_children(node, helper) abort
	return a:helper.async.get_child_nodes(a:node['__key'])
endfunction

function! s:is_leaf(node) abort
	return a:node.status == g:fern#STATUS_NONE || a:node.status == g:fern#STATUS_COLLAPSED
endfunction

function! s:is_branch(node) abort
	return a:node.status == g:fern#STATUS_EXPANDED || a:node.status == g:fern#STATUS_COLLAPSED
endfunction

