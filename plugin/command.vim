" =============================================================================
" Filename:    plugin/mycommand.vim
" Author:      luzhlon
" Date:        2017-08-27
" Description: some useful commands
" =============================================================================
" Show the syntax name under the cursor
com! SynAttr echo synIDattr(synID(line('.'), col('.'), 1), 'name')
" Echo a dict or list with human readable
com! -nargs=+ -complete=expression Echo call <SID>Echo(<args>, 1)
" Clang integration
com! GenClangFormat call <SID>GenClangFormat()
com! -range ClangFormat call <SID>ClangFormat(<line1>, <line2>, <count>)

let s:path = expand('<sfile>:p:h')
" Echo functions {{{ "
let s:deep = 0
fun! s:EchoIndent(...)
    echon repeat('  ', s:deep)
    if a:0|echon join(a:000)|endif
endf
" Format output
fun! s:Echo(d, ...)
    " Is first call
    if a:0 | let s:deep = 0 | endif
    let _t = type(a:d)
    if _t == v:t_dict
        echon "{\n"     |let s:deep += 1
        for i in keys(a:d)
            let v = a:d[i]
            call s:EchoIndent(i, ":\t")
            call s:Echo(v)|echon ",\n"
        endfo
        let s:deep -= 1 |call s:EchoIndent()|echon "}"
    elseif _t == v:t_list
        echon "[\n"     |let s:deep += 1
        for i in a:d
            call s:EchoIndent()
            call s:Echo(i)|echon ",\n"
        endfo
        let s:deep -= 1 |call s:EchoIndent()|echon "]"
    else | echon string(a:d) | endif
endf
" }}} Echo functions "

" Clang functions {{{
fun! s:GenClangFormat()
    let cont = readfile(s:path . '/.clang-format')
    call writefile(cont, '.clang-format')
endf

fun! s:ClangFormat(b, e, count)
    if !exists('g:clang_format_py')
        echoerr 'Please specifies the path of clang-format.py g:clang_format_py'
        return
    endif
    let l:lines = a:count < 0 ? 'all' : (a:b . ':' . a:e)
    exe 'py3f' g:clang_format_py
endf
" }}} Clang functions
