
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
