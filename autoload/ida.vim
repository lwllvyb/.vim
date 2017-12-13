
fun! ida#int2str(intstr)
    let l = []
    try
        let n = eval(a:intstr)
        while n
            call add(l, nr2char(n % 0x100))
            let n = n / 0x100
        endw
        call reverse(l)
        return join(l, '')
    catch
        echo v:errmsg
        return ''
    endt
endf

fun! ida#str2int(str)
    let n = 1
    let l = []
    try
        let n = eval(a:intstr)
        while n
            call add(l, nr2char(n % 0x100))
            let n = n / 0x100
        endw
        call reverse(l)
        return join(l, '')
    catch
        echo v:errmsg
        return ''
    endt
endf

fun! ida#hex2dec(hex)
    return string(type(a:hex) == v:t_string ? eval(a:hex): a:hex)
endf

fun! ida#dec2hex(dec)
    let dec = type(a:dec) == v:t_string ? eval(a:dec): a:dec
    return printf('0x%x', dec)
endf
