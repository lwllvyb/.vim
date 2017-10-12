
fun! ExecOutside(bin, ...)
    " Construct the command lines
    let opt = a:0 ? a:1 : {}
    let tf = tempname() . '.bat'
    let stdin = get(opt, 'stdin', 0)
    let stdout = get(opt, 'stdout', 0)
    let pause = get(opt, 'pause', 1)
    let bin = printf('"%s"', a:bin)
    if !empty(stdin)
        let bin .= printf('<"%s"', stdin)
    endif
    if !empty(stdout)
        let bin .= printf('>"%s"', stdout)
    endif
    let cont = [bin]
    if pause | call add(cont, 'pause') | endif
    call writefile(cont, tf)
    exe printf('sil !start cmd /Q /c "@call %s"', tf)
endf

fun! ShowMonths()
    let m = [
        \ '一月 Jan.January ',
        \ '二月 Feb.February ',
        \ '三月 Mar.March ',
        \ '四月 Apr.April ',
        \ '五月 May.May ',
        \ '六月 June.June ',
        \ '七月 July.July ',
        \ '八月 Aug.Aguest ',
        \ '九月 Sept.September ',
        \ '十月 Oct.October ',
        \ '十一月 Nov.November ',
        \ '十二月 Dec.December ']
    echo join(m, "\n")
endf
