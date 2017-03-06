call popup#add('util-i', 'Util', 
    \['t', '插入日期', "\<c-r>=strftime('%Y/%b/%d')\<cr>"],
    \['m', '插入模式行', "vim: set "])
let sub = [
    \['x', '反斜杠转义    ' , ':s/\\/\\\\/g'."\<cr>"],
    \['c', '反斜杠消除    ' , ':s/\\\\/\\/g'."\<cr>"],
    \['a', '斜杠 → 反斜杠 ' , ':s/\//\\/g'."\<cr>"],
    \['b', '反斜杠 → 斜杠 ' , ':s/\\/\//g'."\<cr>"],
    \['i', '制表符 → 空格 ' , ":s/\t/\\=repeat(' ',\&ts)/g\<cr>"],
    \['l', '消除空行      ' , ":g/^$/del\<cr>"],
    \['s', '消除行尾空白  ' , ':s/\s\+$'."\<cr>"],
    \['m', '消除行尾回车符' , ":s/\<c-v>\<c-m>$/\<cr>"]]
call popup#add('util-n', 'Util',
    \['s', '常用替换   ' , sub],
    \['l', '打开链接   ' , 'gx'],
    \['f', '在文件查找 ' , ':vimgrep '],
    \['h', '开始Hex编辑' , ":set bin|%!xxd\<cr>"],
    \['e', '结束Hex编辑' , ":%!xxd -r\<cr>"])
if has('win32')
    call popup#extend('util-n',
        \['p', '打开命令行 ' , ":!start cmd\<cr>"],
        \['o', '打开文件夹 ' , ":!start explorer %:h\<cr>"])
endif
call popup#add('util-v', 'Util',
    \['r', '替换选中' , 'y:%s/\V\<'."\<c-r>".'"\>/'],
    \['f', '查找选中' , 'y/\V'."\<c-r>\""],
    \['w', '全词查找' , 'y/\V\<'."\<c-r>".'"\>'],
    \['s', '常用替换' , sub],
    \['t', '网页查词' , "y:YouDao \<c-r>\"\<cr>"],
    \['b', '百度搜索' , "y:Baidu \<c-r>\"\<cr>"],
    \['x', '执行VimL' , "y:exe @\"\<cr>"])

imap <expr><m-u>    Popup('util-i')
nmap <expr><space>  Popup('util-n')
vmap <expr><space>  Popup('util-v')
