
" keep a window contain permitted buffers

let s:newwin = {}

fun! s:setwintype()
    if &bt == 'quickfix'
    elseif &bt == 'help'
    elseif &bt == 'terminal'
    endif
endf

fun! s:onbufenter()
    if has_key(s:newwin, win_getid())
        call s:setwintype()
    elseif has_key(w:, 'wintype')
    endif
endf

fun! s:onwinnew()
    let s:newwin[win_getid()] = 1
endf

au WinNew * call <sid>onwinnew()
au BufEnter * call <sid>onbufenter()
