call popup#add('util-i',
\{'name' : 'Util', 'item' : [
    \['c', '插入注释', ""],
    \['t', '插入日期', "\<c-r>=strftime('%Y/%b/%d')\<cr>"],
    \['m', '插入模式行', "vim: set "]
\]})
let sub = {'name': '替换', 'item': [
    \['x', '反斜杠转义    ' , ':s/\\/\\\\/g'."\<cr>"],
    \['c', '反斜杠消除    ' , ':s/\\\\/\\/g'."\<cr>"],
    \['a', '斜杠 → 反斜杠 ' , ':s/\//\\/g'."\<cr>"],
    \['b', '反斜杠 → 斜杠 ' , ':s/\\/\//g'."\<cr>"],
    \['i', '制表符 → 空格 ' , ":s/\t/\\=repeat(' ',\&ts)/g\<cr>"],
    \['s', '消除行尾空白  ' , ':s/\s\+$'."\<cr>"],
    \['m', '消除行尾回车符' , ":s/\<c-v>\<c-m>$/\<cr>"]
\]}
call popup#add('util-n',
\{'name' : 'Util', 'item' : [
    \['s', '常用替换   ' , sub],
    \['l', '打开链接   ' , 'gx'],
    \['m', '构建       ' , ":make\<cr>"],
    \['r', '运行       ' , ":Run\<cr>"],
    \['f', '在文件查找 ' , ':vimgrep '],
    \['h', '开始Hex编辑' , ":set bin|%!xxd\<cr>"],
    \['e', '结束Hex编辑' , ":%!xxd -r\<cr>"],
    \['o', '打开文件夹 ' , ":call system('explorer '.getcwd())\<cr>"]
\]})
call popup#add('util-v',
\{'name' : 'Util', 'item' : [
    \['r', '替换选中' , 'y:%s/\V\<'."\<c-r>".'"\>/'],
    \['f', '查找选中' , 'y/\V'."\<c-r>\""],
    \['w', '全词查找' , 'y/\V\<'."\<c-r>".'"\>'],
    \['s', '常用替换' , sub],
    \['t', '网页查词' , "y:YouDao \<c-r>\"\<cr>"],
    \['b', '百度搜索' , "y:Baidu \<c-r>\"\<cr>"],
    \['x', '执行VimL' , "y:exe @\"\<cr>"]
\]})

imap <expr><m-u>    Popup('util-i')
nmap <expr><space>  Popup('util-n')
vmap <expr><space>  Popup('util-v')
