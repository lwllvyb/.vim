if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

func! s:run_cpp()
    let h = &ch
    set ch=3
    write
    if has('win32')
        !clang % -o a.exe && a.exe
        !del a.exe
    else
        !g++ -o a.out %:p && ./a.out
        !rm a.out
    endif
    let &ch = h
endf

call dict#addl('c', 'cpp')
