
let s:path = expand('<sfile>:h')

fun! env#msvc#gen()
    exe 'py3file' s:path . '/gen_msvc.py'
    return g:_
endf
