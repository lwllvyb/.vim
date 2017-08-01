call popup#add('toggle', 'Toggle',
    \['r', 'Relative', ":set rnu!\<cr>"],
    \['h', 'Highlist', ":set hls!\<cr>"],
    \['w', 'Auto wrap', ":set wrap!\<cr>"],
    \['c', 'Auco CD', ":set acd!\<cr>"],
    \['l', 'List mode', ":set list!\<cr>"],
    \['p', 'Paste mode', ":set paste!\<cr>"],
    \'----------------------------------------',
    \['m', 'Mouse', ":let &mouse=&mouse==''?'a':''\<cr>"],
    \['v', 'Virtual edit', ":let &ve=&ve==''?'all':''\<cr>"],
    \['b', 'Background', ":let &bg=&bg=='dark'?'light':'dark'\<cr>"],
    \['a', 'Pairs completion', ":call AutoPairsToggle()\<cr>"],
    \['g', 'TAGBAR ...', ":TagbarToggle\<cr>"])

nmap <expr><m-;> Popup('toggle')
