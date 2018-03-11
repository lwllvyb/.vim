
" Add some numbers horizontal or vertical
fun! calc#smart_add() range
    let sum = 0
    if a:firstline == a:lastline
        let line = getline('.')
        let nums = split(line, '\s\+')
        for n in nums | let sum += n | endfo
    else
        for n in getline(a:firstline, a:lastline)
            let sum += n
        endfo
    endif
    echo sum
    return ''
endf
