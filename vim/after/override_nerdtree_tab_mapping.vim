call NERDTreeAddKeyMap({'key': 't', 'scope': 'DirNode', 'callback': 'NERDTreePreventDirectoryOpen', 'quickhelpText': 'open dir (not in tab)'})
call NERDTreeAddKeyMap({'key': 't', 'scope': 'FileNode', 'callback': 'NERDTreeMyOpenInTab', 'quickhelpText': 'open file in new tab', 'override': 1 })

function NERDTreeMyOpenInTab(node)
  call a:node.open({'reuse': 'all', 'where': 't'})
endfunction

function NERDTreePreventDirectoryOpen(node)
  call a:node.activate()
endfunction
