
fun! ctf#unicode#encode(data)
endf

fun! ctf#unicode#decode(data)
    return substitute(a:data, 'u\(\x\+\)', '\=nr2char('0x'.submatch(1)+0)', 'g')
endf
