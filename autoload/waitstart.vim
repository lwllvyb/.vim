
let s:path = expand('<sfile>:p:h')

fun! waitstart#(pid, ...)
    let args = copy(a:000)
    let args = join(map(args, {i,v->shellescape(v)}))

    if has('win32')
        call waitstart#_windows(a:pid, args)
    else
        call waitstart#_linux(a:pid, args)
    endif
endf

fun! waitstart#restart()
    let path = fnamemodify(v:progpath, ':h')
    let nvimqt = path . '\nvim-qt.exe'
    if executable(nvimqt)
        call waitstart#(getpid(), nvimqt)
    else
        call waitstart#(getpid(), v:progpath)
    endif
    " conf qa
endf

fun! waitstart#_windows(pid, cmd)
    let tf = tempname() . '.cmd'
    echo tf | call getchar()
    let cont = [
        \ '@echo off',
        \ ':WAIT',
        \ printf('tasklist /FI "PID eq %d" /FO list | findstr %d', a:pid, a:pid),
        \ 'if %ERRORLEVEL% EQU 0 goto WAIT',
        \ 'start "" ' . a:cmd, 'exit']
    call writefile(cont, tf)
    sil exe '!start /MIN cmd /c' 'call' shellescape(tf)
endf

fun! waitstart#_linux(pid, cmd)
endf
