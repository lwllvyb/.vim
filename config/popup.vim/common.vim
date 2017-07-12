call popup#add('file', '文件',
    \['n', '新建    ', ":conf ene\<cr>"],
    \['o', '打开    ', ":browse confirm e\<cr>"],
    \['s', '保存    ', ":w\<cr>"],
    \['d', '关闭    ', ":QuitBuffer\<cr>"],
    \['a', '保存所有', ":wa\<cr>"],
    \['x', '退出    ', ":confirm qa\<cr>"])

call popup#add('window', '窗口',
    \['o', '新建标签页',    ":tabe\<cr>"],
    \['w', '关闭缓冲区',    ":conf bw\<cr>"],
    \['l', '下个标签页',    ":tabn\<cr>"],
    \['h', '上个标签页',    ":tabp\<cr>"],
    \['x', '关闭标签页',    ":tabc\<cr>"],
    \['p', '复制缓冲区',    "ggVGy:bot sp ene!\<cr>Vp"],
    \['c', '关闭窗口  ',    "\<c-w>c"],
    \['s', '窗口大小调整',  [
        \['h', '横向减小', "\<c-w><"],
        \['l', '横向增大', "\<c-w>>"],
        \['j', '纵向减小', "\<c-w>-"],
        \['k', '纵向增大', "\<c-w>+"]]
\])

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
    \['g', 'TAGBAR..', ":TagbarToggle\<cr>"])

call popup#add('goto', '跳转',
    \['f', '函数        ', ""],
    \['d', '定义        ', "gd"],
    \['p', '上个函数    ', "[["],
    \['n', '下个函数    ', "]]"])

call popup#add('insert', '插入', 
    \['t', '日期', "\<c-r>=strftime('%Y/%b/%d')\<cr>"],
    \['f', '文件名', {->expand('%')}],
    \['m', '模式行', "vim: set "])

nmap <expr><m-f> Popup('file')
imap <expr><m-i> Popup('insert')
nmap <expr><m-g> Popup('goto')
nmap <expr><m-;> Popup('toggle')
nmap <expr><m-w> Popup('window')
map  <expr><m-.> popup#last()
map! <expr><m-.> popup#last()
