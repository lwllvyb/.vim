
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

fun! Run()
    if exists('g:xmproj')
        XMake run
    elseif &ft == 'c' || &ft == 'cpp'
        call qrun#cxx()
    endif
endf

nnoremap <silent><F5> :call Run()<cr>
imap <silent><F5> <ESC><F5>
