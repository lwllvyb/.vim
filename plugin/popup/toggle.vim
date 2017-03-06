call popup#add('toggle', '切换',
    \['r', '相对行号        ' , ":set rnu!\<cr>"],
    \['l', '显示空白符      ' , ":set list!\<cr>"],
    \['w', '折行            ' , ":set wrap!\<cr>"],
    \['c', '自动切换当前目录' , ":set acd!\<cr>"],
    \['a', '括号自动补全    ' , ":call AutoPairsToggle()\<cr>"],
    \['p', '粘贴模式        ' , ":set paste!\<cr>"],
    \['m', '鼠标模式        ' , ":let &mouse=&mouse==''?'a':''\<cr>"],
    \['v', '虚拟编辑模式    ' , ":let &ve=&ve==''?'all':''\<cr>"],
    \['b', '背景风格        ' , ":let &bg=&bg=='dark'?'light':'dark'\<cr>"],
    \['g', 'Tagbar          ' , ":TagbarToggle\<cr>"])

nmap <expr><leader> Popup('toggle')
