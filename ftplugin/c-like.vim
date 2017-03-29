
fun! s:CR()
    let [f, b] = lib#curstr(1)
    if f =~ '{$'
        return b =~ '^}' ?
        \ "\<cr>\<esc>O" : "\<cr>}\<esc>O"
    endif
    return "\<cr>"
endf

fun! s:TAB()
    let [f, b] = lib#curstr(1)
    if f =~ ';$'
        return "\<left>()\<left>"
    elseif f =~ '\.$'
        return "\<bs>->"
    endif
    return "\<tab>"
endf

imap <expr><cr> <SID>CR()
imap <expr><tab> <SID>TAB()
