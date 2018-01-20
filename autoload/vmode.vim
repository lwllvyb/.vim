
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

fun! vmode#dump(obj)
    split +ene
    setl ft=json
    try
        let obj = a:obj
        py3 import json
        py3 _ = json.dumps(vim.eval('l:obj'), indent = 4)
        let @x = py3eval('_')
        norm! "xp
    catch
        call setline(1, json_encode(a:obj))
    endt
endf
