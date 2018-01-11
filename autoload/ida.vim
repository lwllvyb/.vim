
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

fun! ida#objc_msgsend()
    " 第一个参数：消息接受对象
    norm f(ldia"_xP
    " 删除消息名两侧的引号
    norm f"ds"
    " 剩余的参数
    norm! f,yl
    while @@ == ','
        norm wdiaF,"_xp
        norm! f,yl
    endw
    " 纠正语法
    norm cs)]hdiw
endf
