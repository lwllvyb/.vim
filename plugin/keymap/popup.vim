call popup#add('file', {'name' : '文件', 'item' : [
    \['n', ":conf ene\<cr>",            '新建'],
    \['o', ":browse confirm e\<cr>",    '打开'],
    \['s', ":w\<cr>",                   '保存'],
    \['d', ":QuitBuffer\<cr>",          '关闭'],
    \['x', ":confirm qa\<cr>",          '退出']
    \]})
call popup#add('view', {'name' : '视图', 'item' : [
    \['e', ":NERDTreeToggle\<cr>",      '文件列表'],
    \['n', ":noh\<cr>",                 '消除高亮']
    \]})
call popup#add('window', {'name' : '窗口', 'item' : [
    \['o', ":tabe\<cr>",                '新建标签页'],
    \['w', ":conf bw\<cr>",             '关闭缓冲区'],
    \['l', ":tabn\<cr>",                '下一个标签页'],
    \['h', ":tabp\<cr>",                '上一个标签页'],
    \['x', ":tabc\<cr>",                '关闭标签页'],
    \['c', "\<c-w>c",                   '关闭当前窗口'],
    \['s', {'name': 'size', 'item': [
        \['h', "\<c-w><",          '横向减小'],
        \['l', "\<c-w>>",          '横向增大'],
        \['j', "\<c-w>-",          '纵向减小'],
        \['k', "\<c-w>+",          '纵向增大']
        \]}]
    \]})
call popup#add('edit-normal', {'name' : '编辑', 'item' : [
    \['c', "\"+yy",                     '复制一行'],
    \['t', "\"+dd",                     '剪切一行'],
    \['p', "\"+p",                      '粘贴'],
    \['a', "ggVG",                      '全选'],
    \['/', ":ToggleComment\<cr>",  '切换注释']
    \]})
call popup#add('edit-visual', {'name' : '编辑', 'item' : [
    \['c', "\"+y",                      '复制'],
    \['t', "\"+d",                      '剪切'],
    \['p', "\"+p",                      '粘贴'],
    \['/', ":ToggleComment\<cr>",       '切换注释']
    \]})
call popup#add('edit-insert', {'name' : '编辑', 'item' : [
    \['(', "()\<left>",                 '插入圆括号'],
    \['[', "[]\<left>",                 '插入方括号'],
    \['{', "{}\<left>",                 '插入花括号'],
    \["'", "''\<left>",                 '插入单引号'],
    \['"', "\"\"\<left>",               '插入双引号']
    \]})
call popup#add('navigate', {'name' : 'Navigate', 'item' : [
    \['w', "\<Plug>(easymotion-w)", 'EasymotionW'],
    \['b', "\<Plug>(easymotion-b)", 'EasymotionB'],
    \['j', "\<Plug>(easymotion-j)", 'EasymotionJ'],
    \['k', "\<Plug>(easymotion-k)", 'EasymotionK'],
    \['1', "\<Plug>(easymotion-overwin-f)", 'Easymotion overwin find'],
    \['2', "\<Plug>(easymotion-overwin-f2)", 'Easymotion overwin find 2'],
    \]})
call popup#add('toggle', {'name' : '切换', 'item' : [
    \['r', ":set rnu!\<cr>",            '相对行号'],
    \['l', ":set list!\<cr>",           '显示空白符'],
    \['w', ":set wrap!\<cr>",           '折行'],
    \['a', ":set acd!\<cr>",            '自动切换当前目录'],
    \['m', ":let &mouse=&mouse==''?'a':''\<cr>", '鼠标模式'],
    \['v', ":let &ve=&ve==''?'all':''\<cr>", '虚拟编辑模式'],
    \['b', ":let &bg=&bg=='dark'?'light':'dark'\<cr>", '背景风格'],
    \['g', ":TagbarToggle\<cr>",        'Tagbar'],
    \]})
call popup#add('util-insert', {'name' : 'Util', 'item' : [
    \['c', "", '插入注释'],
    \['t', "\<c-r>=strftime('%Y/%b/%d')\<cr>", '插入日期']
    \]})
call popup#add('util-normal', {'name' : 'Util', 'item' : [
    \['h', ":set bin|%!xxd\<cr>",       '开始Hex编辑'],
    \['e', ":%!xxd -r\<cr>",            '结束Hex编辑'],
    \['b', ":Tabularize ",              'Tabularize对齐'],
    \['x', "\<Plug>(SoLine)",      '执行VimL'],
    \['t', ":YouDao\<cr>\<cr>",    '网页查词'],
    \['s', {'name': '替换', 'item': [
        \['u', ':s/u\(\x\+\)/\=nr2char'."('0x'.submatch(1)+0)/g\<cr>", '解密Unicode字符'],
        \['x', ':s/\\/\\\\/g'."\<cr>", '反斜杠转义'],
        \['x', ':s/\\\\/\\/g'."\<cr>", '反斜杠转义消除'],
        \['i', ":%s/	/\\=repeat(' ',\&ts)/g\<cr>",'<Tab>→<space>'],
        \['m', ":%s/\<c-v>\<c-m>$/\<cr>",         '消除行尾^M']
        \]}]
    \]})
call popup#add('util-visual', {'name' : 'Util', 'item' : [
    \['f', "y/\<c-r>\"",            '查找选中文本'],
    \['a', {'name': '制表符', 'item': [
        \['j', {'name': '角', 'item': [ 
            \['a', 'r┌', ''],
            \['b', 'r┬', ''],
            \['c', 'r┐', ''],
            \['d', 'r├', ''],
            \['e', 'r┼', ''],
            \['f', 'r┤', ''],
            \['g', 'r└', ''],
            \['h', 'r┴', ''],
            \['i', 'r┘', '']
            \]}],
        \['b', {'name': '边', 'item': [ 
            \['a', 'r─', ''],
            \['b', 'r│', '']
            \]}],
        \]}],
    \['x', "\<Plug>(SoLines)",     '执行VimL']
    \]})

map  <expr><m-.>    popup#lastcmd()
map! <expr><m-.>    popup#lastcmd()
nmap <expr><m-n>    popup#popup('navigate')
nmap <expr><m-f>    popup#popup('file')
nmap <expr><m-v>    popup#popup('view')
nmap <expr><m-w>    popup#popup('window')
nmap <expr><leader> popup#popup('toggle')
nmap <expr><m-e>    popup#popup('edit-normal')
vmap <expr><m-e>    popup#popup('edit-visual')
map! <expr><m-e>    popup#popup('edit-insert')
imap <expr><m-u>    popup#popup('util-insert')
nmap <expr><space>  popup#popup('util-normal')
vmap <expr><space>  popup#popup('util-visual')
