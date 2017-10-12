
setl binary

try
    py3 import pefile
catch
    finish
endt

" set bt=nofile
set nomodifiable
0,$delete _

let s:path = expand('<sfile>:h')
exe 'py3f' s:path . '/vim-pe.py'

setl foldmethod=indent
setl foldlevel=0
