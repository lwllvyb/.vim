if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

"setl foldmethod=indent
"
let b:py3 = getline(1) =~ 'python$' ? 0: 1

com -buffer UsePy let b:py3 = 0
com -buffer UsePy3 let b:py3 = 1

fun! s:run_ipy()
    write
    exe (b:py3?'!ipython3 -i': '!ipython -i') . ' %:p'
endf
fun! s:run_py()
    write
    exe (b:py3?'!python3 -i': '!python -i') . ' %:p'
endf

nnoremap <buffer> <silent> <F5> :call <SID>run_ipy()<cr>
nnoremap <buffer> <silent> <F6> :call <SID>run_py()<cr>
