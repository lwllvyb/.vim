" =============================================================================
" Filename:    autoload\echo.vim
" Author:      luzhlon
" Date:        2017-10-14
" Description: Echo a viml-variable with human-readable format
" =============================================================================

let s:path = expand('<sfile>:p:h')

" Echo functions {{{ "
let s:deep = 0
fun! s:EchoIndent(...)
    echon repeat('  ', s:deep)
    if a:0|echon join(a:000)|endif
endf
" Format output
fun! echo#(d, ...)
    " Is first call
    if a:0 | let s:deep = 0 | endif
    let _t = type(a:d)
    if _t == v:t_dict
        echon "{\n"     |let s:deep += 1
        for i in keys(a:d)
            let V = a:d[i]
            call s:EchoIndent(i, ":\t")
            call echo#(V)|echon ",\n"
        endfo
        let s:deep -= 1 |call s:EchoIndent()|echon "}"
    elseif _t == v:t_list
        echon "[\n"     |let s:deep += 1
        for I in a:d
            call s:EchoIndent()
            call echo#(I)|echon ",\n"
        endfo
        let s:deep -= 1 |call s:EchoIndent()|echon "]"
    else | echon strtrans(string(a:d)) | endif
endf
" }}} Echo functions "
