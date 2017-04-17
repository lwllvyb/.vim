scripte utf-8
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

nmap <expr><m-w> Popup('window')
