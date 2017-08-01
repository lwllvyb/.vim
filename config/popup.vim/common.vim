scripte utf-8

call popup#add('file', 'File',
    \['n', 'New', ":conf ene\<cr>"],
    \['o', 'Open', ":browse confirm e\<cr>"],
    \['s', 'Save', ":w\<cr>"],
    \['d', 'Close', ":QuitBuffer\<cr>"],
    \['a', 'Save all', ":wa\<cr>"],
    \['x', 'Exit', ":confirm qa\<cr>"])

call popup#add('goto', 'Jump',
    \['f', 'Function', ""],
    \['d', 'Implentation', "gd"],
    \['p', 'Previous', "[["],
    \['n', 'Next Function', "]]"])

call popup#add('insert', 'Insert',
    \['t', 'Date', {->strftime('%Y/%b/%d')}],
    \['f', 'File name', {->expand('%')}],
    \['m', 'Modeline', "vim: set "])

nmap <expr><m-f> Popup('file')
imap <expr><m-i> Popup('insert')
nmap <expr><m-g> Popup('goto')
map  <expr><m-.> popup#last()
map! <expr><m-.> popup#last()

let g:popup#upkey = "\<c-h>"
