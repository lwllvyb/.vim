
fun! vmode#goto_define()
    let fname = expand('<cword>')
    let sps = split(fname, '#')
    if len(sps) > 1
        call remove(sps, -1)
        let f = findfile('autoload/' . join(sps, '/') . '.vim', &rtp)
        if empty(f)
            echoe 'Not found' | return
        endif
        exe 'e' f
    endif
    return vmode#search_fun(fname)
endf

" nnoremap <Plug>(GoToVimLet) /\s*let\s\+.*<c-r>=expand('<cword>')<cr>
fun! vmode#search_fun(func)
    return search('\<fu\%[nction]!\?.*\zs' . a:func)
endf

fun! vmode#search_var(var)
    return search('\<let\s\+.*\zs' . a:var)
endf
