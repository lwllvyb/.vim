call popup#add('window', 'Window&Buffer',
    \['t', 'Tabpage', [
        \['o', 'New', ":tabe\<cr>"],
        \['x', 'Close', ":tabc\<cr>"],
        \['p', 'Previous', "gT"],
        \['n', 'Next', "gt"]]],
    \['p', 'Previous File', ":PrevFile\<cr>"],
    \['n', 'Next File', ":NextFile\<cr>"],
    \['v', 'Split',   ":vert sb! "],
    \['w', 'Wipe buffer', ":conf bw\<cr>"],
    \['p', 'Copy buffer', "ggVGy:bot sp ene!\<cr>Vp"],
    \['s', 'Resize',  [
        \['h', '<=> ++', "\<c-w><"],
        \['l', '<=> --', "\<c-w>>"],
        \['j', '||| --', "\<c-w>-"],
        \['k', '||| ++', "\<c-w>+"]]])

nmap <expr><m-w> Popup('window')
