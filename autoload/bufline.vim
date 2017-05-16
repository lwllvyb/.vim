" =============================================================================
" Filename:     autoload/bufline.vim
" Author:       luzhlon
" Function:     Provides a simple buffer-line utility
" Last Change:  2017/3/25
" =============================================================================
let s:files = []    " files bufnrs

let s:hiSel = '%#TabLineSel#'
let s:hiNonSel = '%#TabLine#'
" Get all buffers of common files
fun! s:getfiles()
    return filter(getbufinfo({'buflisted':1}),
                \ {i,v->empty(getbufvar(v['bufnr'], '&bt'))})
endf
" Select a buffer
fun! s:select(n)
    if a:n <= len(s:files)
        exe 'b!' s:files[a:n-1]['bufnr']
    endif
endf
fun! bufline#files()
    return s:getfiles()
endf
" set tabline=%!bufline#()
fun! bufline#(...)
    if a:0 | return s:select(a:1) | endif
    let curnr = bufnr('%')
    let i = 1 | let l = []
    let s:files = s:getfiles()
    for buf in s:files
        let nr = buf['bufnr']
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
