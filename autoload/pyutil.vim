
fun! pyutil#bp()
endf

fun! pyutil#import(m)
    let i = 1
    let end = line('$')
    while i < end
        echo matchstr('^\s*import\s\+\(\S\+\)', getline(i))
        let i += 1
    endw
endf
