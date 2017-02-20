call popup#add('util-insert',
\{'name' : 'Util', 'item' : [
    \['c', '插入注释', ""],
    \['t', '插入日期', "\<c-r>=strftime('%Y/%b/%d')\<cr>"]
\]})
let sub = {'name': '替换', 'item': [
    \['u', '解密Unicode  ' , ':s/u\(\x\+\)/\=nr2char'."('0x'.submatch(1)+0)/g\<cr>"],
    \['x', '反斜杠转义   ' , ':s/\\/\\\\/g'."\<cr>"],
    \['c', '反斜杠消除   ' , ':s/\\\\/\\/g'."\<cr>"],
    \['s', '行尾空白     ' , ':s/\s\+$'."\<cr>"],
    \['i', '<Tab>→<space>' , ":s/\t/\\=repeat(' ',\&ts)/g\<cr>"],
    \['m', '消除行尾^M   ' , ":s/\<c-v>\<c-m>$/\<cr>"]
\]}
call popup#add('util-n',
\{'name' : 'Util', 'item' : [
    \['h', '开始Hex  ' , ":set bin|%!xxd\<cr>"],
    \['e', '结束Hex  ' , ":%!xxd -r\<cr>"],
    \['b', 'Tab..对齐' , ":Tabularize "],
    \['x', '执行VimL ' , "\<Plug>(SoLine)"],
    \['t', '网页查词 ' , ":YouDao\<cr>\<cr>"],
    \['s', '替换     ' , sub]
\]})
call popup#add('util-v',
\{'name' : 'Util', 'item' : [
    \['*', '替换选中文本' , 'y:%s/\V'."\<c-r>".'"\>/'],
    \['s', '替换        ' , sub],
    \['x', '执行VimL    ' , "\<Plug>(SoLines)"]
\]})

imap <expr><m-u>    Popup('util-insert')
nmap <expr><space>  Popup('util-n')
vmap <expr><space>  Popup('util-v')
