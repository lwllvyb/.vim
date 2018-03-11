
let s:path = expand('<sfile>:h')

fun! env#clang#init()
    call extend(g:, env#get('clang'))
endf

fun! env#clang#gen()
    exe 'py3file' s:path . '/gen_clang.py'
    return g:_
endf
