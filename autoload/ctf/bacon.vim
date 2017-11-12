
let s:table = {
    \ 'A': 'aaaaa', 'B': 'aaaab', 'C': 'aaaba',
    \ 'D': 'aaabb', 'E': 'aabaa', 'F': 'aabab',
    \ 'G': 'aabba', 'H': 'aabbb', 'I': 'abaaa',
    \ 'J': 'abaab', 'K': 'ababa', 'L': 'ababb',
    \ 'M': 'abbaa', 'N': 'abbab', 'O': 'abbba',
    \ 'P': 'abbbb', 'Q': 'baaaa', 'R': 'baaab',
    \ 'S': 'baaba', 'T': 'baabb', 'U': 'babaa',
    \ 'V': 'babab', 'W': 'babba', 'X': 'babbb',
    \ 'Y': 'bbaaa', 'Z': 'bbaab'
    \ }

fun! s:init()
    for [k, v] in items(s:table)
        let s:table[v] = k
    endfor
endf

call s:init()

fun! ctf#bacon#encode(data)
    let data = toupper(a:data)
    return substitute(data, '\u', {m -> s:table[m[0]]}, 'g')
endf

fun! ctf#bacon#decode(data)
    let data = tolower(a:data)
    return substitute(data, '[ab]\{5}', {m -> s:table[m[0]]}, 'g')
endf
