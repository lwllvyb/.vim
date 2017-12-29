
nnoremap <buffer><silent>o :lua require'nui.Tree'.CurNode():toggle()<cr>
nnoremap <buffer><silent>p :lua require'nui.Tree'.CurNode():move2parent()<cr>
