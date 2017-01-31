if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

func! s:run_c()
    write
    if has('win32')
        !clang % -o a.exe && a.exe
        !del a.exe
    else
        !gcc -o a.out %:p && ./a.out
        !rm a.out
    endif
endf

nnoremap <buffer> <C-F5> :call <SID>run_c()<cr>
