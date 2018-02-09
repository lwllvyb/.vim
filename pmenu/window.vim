
fun! ResizeWindow()
    let com_table = {
        \ 'h': 'winc <',
        \ 'l': 'winc >',
        \ 'k': 'winc +',
        \ 'j': 'winc -'}
    while 1
        echo 'press h/j/k/l/i/o/I/O ...'
        let c = getchar()
        if type(c) == v:t_number
            let c = nr2char(c)
        endif
        if c ==# 'i'
            exe 'resize' winheight('%')/2
        elseif c ==# 'I'
            exe 'vert resize' winwidth('%')/2
        elseif c ==# 'o'
            exe 'resize' winheight('%')*2
        elseif c ==# 'O'
            exe 'vert resize' winwidth('%')*2
        else
            if !has_key(com_table, c)
                break | endif
            exe com_table[c]
        endif
        redraw
    endw
    redraw
endf

call popup#reg('window', pmenu#new('Window & Buffer',
    \ ['o:', 'New tabpage', 'tabe'],
    \ ['x:', 'Close tabpage', 'tabc'],
    \ ['p!', 'Prev tabpage', 'gT'],
    \ ['n!', 'Next tabpage', 'gt'],
    \ '------------------------------',
    \ ['w', 'Wipe', "\<c-w>\<c-u>"],
    \ ['s:', 'Resize',  'call ResizeWindow()'],
    \ ['c', 'Copy buffer', "ggVGy:bot sp ene!\<cr>Vp"]
\ ))
