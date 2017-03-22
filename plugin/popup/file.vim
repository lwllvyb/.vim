call popup#add('file', '文件',
    \['n', '新建', ":conf ene\<cr>"],
    \['o', '打开', ":browse confirm e\<cr>"],
    \['s', '保存', ":w\<cr>"],
    \['d', '关闭', ":QuitBuffer\<cr>"],
    \['x', '退出', ":confirm qa\<cr>"])

nmap <expr><silent><m-f> Popup('file')
map  <expr><silent><m-.> popup#last()
map! <expr><silent><m-.> popup#last()
