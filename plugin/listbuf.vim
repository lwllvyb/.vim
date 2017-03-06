fun! s:onEnter()
    let line = getline('.')
    let nr = matchstr(line, '^\w\+\s\+\zs\d\+')
    let wnr = winnr()
    winc p
    exe wnr . 'winc c'
    if !empty(nr)
        exe 'b!' nr
    endif
endf
fun! s:show()
    bot vs|vert res 30
    if exists('s:list_nr') && bufexists(s:list_nr)
        exe s:list_nr.'b'
        set modifiable
        norm! ggVGd
    else
        ene! | let s:list_nr = bufnr('%')
        setl nowrap nolist sw=3 nonu bt=nofile bh=hide nobl
        com! -buffer Enter call <SID>onEnter()
        map <buffer><cr> :Enter<cr>
        syn match Underlined /^\w/
        syn match Boolean /\%>4c.*/
    endif
    set modifiable
endf

fun! ListBuffer()
    let bs = getbufinfo({'buflisted':1})
    let m = {}
    let i = char2nr('a')
    let N = bufnr('#')

    call s:show()
    for d in bs
        let n = d.bufnr
        if !empty(getbufvar(n, '&bt'))
            continue
        endif
        let c = nr2char(i)
        call append('$', join([c,printf("%2d",n),bufname(n)]))
        let m[c] = d['bufnr']
        let i += 1
    endfo
    set nomodifiable
    redraw!
    let i = nr2char(getchar())
    let k = has_key(m, i) ? m[i]: ((i=='.'||i=="\<m-.>")?N:0)
    if k
        winc c
        exe 'b!' k
        return ''
    else
        return '/'
    endif
endf
