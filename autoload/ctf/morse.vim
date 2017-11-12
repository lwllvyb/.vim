
let s:table = {
    \ 'A': '.-'    , 'B': '-...'  , 'C': '-.-.',
    \ 'D': '-..'   , 'E': '.'     , 'F': '..-.'  ,
    \ 'G': '--.'   , 'H': '....'  , 'I': '..'    ,
    \ 'J': '.---'  , 'K': '-.-'   , 'L': '.-..'  ,
    \ 'M': '--'    , 'N': '-.'    , 'O': '---'   ,
    \ 'P': '.--.'  , 'Q': '--.-'  , 'R': '.-.'   ,
    \ 'S': '...'   , 'T': '-'     , 'U': '..-'   ,
    \ 'V': '...-'  , 'W': '.--'   , 'X': '-..-'  ,
    \ 'Y': '-.--'  , 'Z': '--..'  ,
    \ '0': '-----' , '1': '.----' , '2': '..---' ,
    \ '3': '...--' , '4': '....-' , '5': '.....' ,
    \ '6': '-....' , '7': '--...' , '8': '---..' ,
    \ '9': '----.'
    \ }

fun! s:init()
    for [k, v] in items(s:table)
        let s:table[v] = k
    endfor
endf

call s:init()

fun! ctf#morse#encode(data)
    let data = toupper(a:data)
    let len = strchars(data)
    let i = 0
    let l = []
    while i < len
        let c = strcharpart(data, i, 1)
        call add(l, get(s:table, c, c))
        let i += 1
    endw
    return join(l)
endf

fun! ctf#morse#decode(data)
    return substitute(a:data, '[\.-]\+', {m -> s:table[m[0]]}, 'g')
endf
