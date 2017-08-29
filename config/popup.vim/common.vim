scripte utf-8

call popup#add('file', 'File',
    \['n', 'New', ":conf ene\<cr>"],
    \['o', 'Open', ":browse confirm e\<cr>"],
    \['e', 'Temp', ":conf e \<c-r>=$TEMP\<cr>/"],
    \'-----------------------------------------',
    \['s', 'Save', ":w\<cr>"],
    \['d', 'Close', ":QuitBuffer\<cr>"],
    \['a', 'Save all', ":wa\<cr>"],
    \['x', 'Exit', ":confirm qa\<cr>"])

call popup#add('goto', 'Jump',
    \['f', 'Function', ""],
    \['d', 'Implentation', "gd"],
    \['p', 'Previous', "[["],
    \['n', 'Next Function', "]]"])

nmap <expr><m-f> Popup('file')
nmap <expr><m-g> Popup('goto')
map  <expr><m-.> popup#last()
map! <expr><m-.> popup#last()

let g:popup#upkey = "\<c-h>"
