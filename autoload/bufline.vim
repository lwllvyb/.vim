" =============================================================================
" Filename:     autoload/bufline.vim
" Author:       luzhlon
" Function:     Provides a simple buffer-line utility
" Last Change:  2017/3/25
" =============================================================================
let s:files = []    " files bufnrs

let s:hiSel = '%#TabLineSel#'
let s:hiNonSel = '%#TabLine#'
" Get buffer list of tabpages
fun! s:tabsbufnr()
    let list = []
    for i in range(1, tabpagenr('$'))
        let fl = tabpagebuflist(i)
        let j = tabpagewinnr(i)-1
        let nr = fl[j]
        let e = j
        while !empty(getbufvar(nr, '&bt'))
            let j = (j+1) % len(fl)
            if j == e | break | endif
            let nr = fl[j]
        endw
        call add(list, nr)
    endfo
    return list
endf
" Get all buffers of common files
fun! s:filesbufnr()
    return map(filter(getbufinfo({'buflisted':1}),
                \ {i,v->empty(getbufvar(v['bufnr'], '&bt'))}),
                \ {i,v->v['bufnr']})
endf
" Select a buffer
fun! bufline#(n)
    let n = a:n - 1
    if n < len(s:files)
        exe s:files[n] 'b!'
    endif
endf
" set tabline=%!bufline#bufs()
fun! bufline#bufs()
    let s:files = s:filesbufnr()
    return s:get(s:files)
endf
" set tabline=%!bufline#tabs()
fun! bufline#tabs()
    return s:get(s:tabsbufnr())
endf

fun! s:get(nrs)
    let curnr = bufnr('%')
    let i = 1 | let l = []
    for nr in a:nrs
        call add(l, '%'.i.'T')
        call add(l, nr == curnr ? s:hiSel: s:hiNonSel)
        call add(l, ' '.i.' ')
        let file = simplify(bufname(nr))
        let file = fnamemodify(file, ':.:gs?\(.\).\{-}[\\\/]?\1\/?')
        call add(l, empty(file) ? '<unamed>': file)
        call add(l, getbufvar(nr, '&mod') ? '*': '')
        call add(l, ' ')
        let i = i + 1
    endfor
    call add(l, '%T%#TabLineFill#%=')
    call add(l, tabpagenr('$') > 1 ? '%999XX' : 'X')
    return join(l, '')
endf
