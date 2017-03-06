fun! s:onEnter()
    let line = getline('.')
    winc c
endf
fun! s:show()
    bot vs|vert res 30
    if exists('s:list_nr') && bufexists(s:list_nr)
        exe s:list_nr.'b'
        norm! ggVGd
    else
        ene! | let s:list_nr = bufnr('%')
        setl nomodified nowrap nolist sw=3 nonu bt=nofile bh=hide
        com! -buffer Enter call <SID>onEnter()
        map <buffer><cr> :Enter<cr>
    endif
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
        call append('$', join([c,printf("%3d",n),bufname(n)]))
        let m[c] = d['bufnr']
        let i += 1
    endfo
    redraw!
    let i = nr2char(getchar())
    let k = has_key(m, i) ? m[i]: ((i=='.'||i=="\<m-.>")?N:0)
    if k
        winc c
        exe 'b!' k
    endif
endf
