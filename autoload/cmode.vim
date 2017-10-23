
let s:path = expand('<sfile>:p:h')

fun! cmode#add_inc(f)
    let l = search('^#include', 'b')
    exe 'norm!' (l ? 'o': 'ggO') . '#include ' . a:f
    if empty(a:f)
        startinsert!
    else
        norm ''
    endif
endf

" Generate the macro that prevent reincluding for headers
fun! cmode#genIncMacro()
    let h = toupper(expand('%:t'))
    let h = substitute(h, '[^A-Z0-9]', '_', 'g')
    let h = '__' . h . '__'
    norm! ggO
    call setline(1, '#ifndef ' . h)
    call append(1,  '#define ' . h)
    norm! Go
    call setline('$', '#endif /* ' . h . ' */')
endf
" Switch to file f
fun! s:switch2(f)
    let nr = bufnr(a:f)
    if nr < 0
        exe 'badd' a:f
    endif
    exe 'b!' a:f
endf
" Toggle the header and source file
fun! cmode#toggleHeader()
    let r =  expand('%:r')
    if index(['c','cpp','cc'], expand('%:e')) < 0
        for e in ['c','cpp','cc']
            let f = r . '.' . e
            if filereadable(f)
                return s:switch2(f)
            endif
        endfo
        echo 'No source file.'
    else
        for e in  ['h', 'hpp']
            let f = r . '.' . e
            if filereadable(f)
                return s:switch2(f)
            endif
        endfo
        echo 'No header file.'
    endif
endf
