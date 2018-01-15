
fun! test#nop(...)
    call timer_start(10, {id->execute('print')})
    return ''
endf
