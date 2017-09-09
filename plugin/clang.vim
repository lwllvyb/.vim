
let s:path = expand('<sfile>:p:h')

" Clang integration
com! GenClangFormat call <SID>GenClangFormat()
com! -range ClangFormat call <SID>ClangFormat(<line1>, <line2>, <count>)
com! ClangRename call <SID>ClangRename()

" Clang functions {{{
fun! s:GenClangFormat()
    let cont = readfile(s:path . '/.clang-format')
    call writefile(cont, '.clang-format')
endf

let s:checked = 0
fun! s:CheckVar(var)
    if !s:checked
        exe 'py3f' (s:path . '/find-clang.py')
    endif
    let e = exists(a:var)
    if !e
        echo 'can not find' a:var
    endif
    let s:checked = 1
    return e
endf

fun! s:ClangFormat(b, e, count)
    if !s:CheckVar('g:clang_format_py')
        return
    endif
    let l:lines = a:count < 0 ? 'all' : (a:b . ':' . a:e)
    exe 'py3f' g:clang_format_py
endf
fun! s:ClangRename()
    if !s:CheckVar('g:clang_rename_py')
        return
    endif
    update
    exe 'pyf' g:clang_rename_py
endf
" }}} Clang functions
