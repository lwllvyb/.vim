scripte utf-8

call popup#add('toggle', '切换',
    \['r', '相对行号', ":set rnu!\<cr>"],
    \[';', '高亮匹配', ":set hls!\<cr>"],
    \['l', '显示空白', ":set list!\<cr>"],
    \['w', '自动折行', ":set wrap!\<cr>"],
    \['c', '自动目录', ":set acd!\<cr>"],
    \['p', '粘贴模式', ":set paste!\<cr>"],
    \['m', '鼠标模式', ":let &mouse=&mouse==''?'a':''\<cr>"],
    \['v', '虚拟编辑', ":let &ve=&ve==''?'all':''\<cr>"],
    \['b', '背景风格', ":let &bg=&bg=='dark'?'light':'dark'\<cr>"],
    \['a', '括号补全', ":call AutoPairsToggle()\<cr>"],
    \['g', 'Tagbar  ', ":TagbarToggle\<cr>"])

nmap <expr><m-;> Popup('toggle')
