if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

fun! s:WinRun()
    make -o _a.exe
    if !v:shell_error
        !_a.exe
        !del _a.exe
    endif
endf

fun! s:NixRun()
    make -o _a.out
    if !v:shell_error
        !./_a.out
        !rm _a.out
    endif
endf

fun! s:Run()
    let opt = lib#storeopt('mp', 'ch')
    set ch=3
    write
    set mp=gcc
    if has('win32')
        call s:WinRun()
    else
        call s:NixRun()
    endif
    call lib#restoreopt(opt)
endf

com! -buffer Run call <SID>Run()

call dict#addl('c')
