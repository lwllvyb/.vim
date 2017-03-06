" =============================================================================
" Filename:     plugin/pylib.vim
" Author:       luzhlon
" Function:     
" Last Change:  
" =============================================================================

if !has('python3')
    finish
endif

let path = expand('<sfile>:p:h')
let path = simplify(path . '/../pylib')

py3 import sys;
  \ sys.path.append(vim.eval('path'))

for f in split(glob(path . '/*.vim'), "\n")
    try | exe 'so' f | catch | endt
endfo
