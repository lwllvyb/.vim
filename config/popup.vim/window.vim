
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

call popup#add('window', 'Window & Buffer',
    \ ['o', 'New tabpage', ":tabe\<cr>"],
    \ ['x', 'Close tabpage', ":tabc\<cr>"],
    \ ['p', 'Prev tabpage', 'gT'],
    \ ['n', 'Next tabpage', 'gt'],
    \ '------------------------------',
    \ ['v', 'Split', ":Bufline 'split', 'right'\<cr>"],
    \ ['w', 'Wipe', ":setl bh=wipe | winc c\<cr>"],
    \ ['s', 'Resize',  ":call ResizeWindow()\<cr>"],
    \ ['u', 'Unload buffer', ":bun\<cr>"],
    \ ['c', 'Copy buffer', "ggVGy:bot sp ene!\<cr>Vp"])

nmap <expr><silent><m-w> Popup('window')
