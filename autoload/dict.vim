
let s:path = expand('<sfile>:h')
let s:dictpath = simplify(s:path . '/../dict/')

fun! dict#add(...)
    for dict in a:000
        let file = s:dictpath . dict
        if filereadable(file)
            exe 'set dictionary+=' . file
        endif
    endfor
endf

fun! dict#addl(...)
    for dict in a:000
        let file = s:dictpath . dict
        if filereadable(file)
            exe 'setl dictionary+=' . file
        endif
    endfor
endf
