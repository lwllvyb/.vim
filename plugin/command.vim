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
com! EchoRtp call <SID>Echo(split(&rtp, ','), 1)

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
            let V = a:d[i]
            call s:EchoIndent(i, ":\t")
            call s:Echo(V)|echon ",\n"
        endfo
        let s:deep -= 1 |call s:EchoIndent()|echon "}"
    elseif _t == v:t_list
        echon "[\n"     |let s:deep += 1
        for I in a:d
            call s:EchoIndent()
            call s:Echo(I)|echon ",\n"
        endfo
        let s:deep -= 1 |call s:EchoIndent()|echon "]"
    else | echon strtrans(string(a:d)) | endif
endf
" }}} Echo functions "

if has('win32') && has('python3')
    fun! EnableIME(e)
        py3 import ctypes
        py3 imm = ctypes.WinDLL('imm32.dll')
        py3 print(imm.ImmAssociateContext(vim.eval('g:GuiWindowId'), 0))
    endf
    com! IMEDisable call EnableIME(0)
endif
