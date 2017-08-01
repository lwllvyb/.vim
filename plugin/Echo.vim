
let s:deep = 0
fun! s:echopre(...)
    echon repeat('  ', s:deep)
    if a:0|echon join(a:000)|endif
endf
" Format output
fun! s:echo(d)
    let _t = type(a:d)
    if _t == v:t_dict
        echon "{\n"     |let s:deep += 1
        for i in keys(a:d)
            let v = a:d[i]
            call s:echopre(i, ":\t")
            call s:echo(v)|echon ",\n"
        endfo
        let s:deep -= 1 |call s:echopre()|echon "}"
    elseif _t == v:t_list
        echon "[\n"     |let s:deep += 1
        for i in a:d
            call s:echopre()
            call s:echo(i)|echon ",\n"
        endfo
        let s:deep -= 1 |call s:echopre()|echon "]"
    else    |echon a:d  |endif
endf

fun! Echo(d)
    let s:deep = 0
    call s:echo(a:d)
endf

com! -nargs=+ -complete=expression Echo call Echo(<args>)
