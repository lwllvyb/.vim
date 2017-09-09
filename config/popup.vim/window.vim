fun! s:CloseWindow()
    let wid = win_getid()
    if &bt=='nofile' && 2 == confirm('Not a file, close ???', "&Yes\n&No", 2, "Warning")
        return
    endif
    conf bw
    if win_getid() == wid
        winc c
    endif
endf

fun! s:ResizeWindow()
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

com! CloseWindow call <SID>CloseWindow()
com! ResizeWindow call <SID>ResizeWindow()

call popup#add('window', 'Window&Buffer',
    \['t', 'Tabpage', [
        \['o', 'New', ":tabe\<cr>"],
        \['x', 'Close', ":tabc\<cr>"],
        \['p', 'Previous', "gT"],
        \['n', 'Next', "gt"]]],
    \['p', 'Previous', ":PrevFile\<cr>"],
    \['n', 'Next', ":NextFile\<cr>"],
    \['v', 'Split', ":vert sb! "],
    \['w', 'Close', ":CloseWindow\<cr>"],
    \['p', 'Copy buffer', "ggVGy:bot sp ene!\<cr>Vp"],
    \['s', 'Resize',  ":ResizeWindow\<cr>"])

nmap <expr><m-w> Popup('window')
