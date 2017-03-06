" =============================================================================
" Filename:     plugin/ctf.vim
" Author:       luzhlon
" Function:     
" Last Change:  2017/1/30
" =============================================================================

py3 import ctf

fun! s:filter(l, k)
    let l = []
    for i in a:l
        if i =~ a:k
            call add(l, i)
        endif
    endfor
    return l
endf
fun! s:en_com(a, c, p)
    return s:filter(['base64', 'url', 'morse'], a:a)
endf
fun! s:de_com(a, c, p)
    return s:filter(['rot13', 'base64', 'unicode', 'url', 'morse', 'bacon', 'fence'], a:a)
endf

fun! s:encode(t)
    try
        call ctf#en#{a:t}()
    endt
endf
fun! s:decode(t)
    try
        call ctf#de#{a:t}()
    endt
endf

com! -complete=customlist,<SID>en_com -nargs=+ Encode call <SID>encode(<f-args>)
com! -complete=customlist,<SID>de_com -nargs=+ Decode call <SID>decode(<f-args>)
