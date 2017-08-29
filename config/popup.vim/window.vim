fun! s:CloseWindow()
    if &bt=='nofile' && 2 == confirm('Not a file, close ???', "&Yes\n&No", 2, "Warning")
        return
    endif
    conf bw
endf
com! CloseWindow call <SID>CloseWindow()

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
    \['s', 'Resize',  [
        \['h', '<=> ++', "\<c-w><"],
        \['l', '<=> --', "\<c-w>>"],
        \['j', '||| --', "\<c-w>-"],
        \['k', '||| ++', "\<c-w>+"]]])

nmap <expr><m-w> Popup('window')
