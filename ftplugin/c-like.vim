
fun! s:CR()
    let [f, b] = lib#curstr(1)
    if f =~ '{$'
        return b =~ '^}' ?
        \ "\<cr>\<esc>O" : "\<cr>}\<esc>O"
    endif
    return "\<cr>"
endf

imap <expr><cr> <SID>CR()
