scripte utf-8
let sub = [['/', '斜杠反斜杠', [
              \['x', '反斜杠转义    ' , ':s/\\/\\\\/g'."\<cr>"],
              \['c', '反斜杠消除    ' , ':s/\\\\/\\/g'."\<cr>"],
              \['a', '斜杠 → 反斜杠 ' , ':s/\//\\/g'."\<cr>"],
              \['b', '反斜杠 → 斜杠 ' , ':s/\\/\//g'."\<cr>"]]],
          \['c', '中文标点  ', [
              \['m', '冒号', ":s:/：/:/g\<cr>"],
              \['q', '括号', ":s:/（\\(.\\{-}\\)）/\1/g\<cr>"]]],
          \['x', '个数替换  ', ":s/\<c-r>//\\=repeat('-', len(submatch(0)))"],
          \['s', '空白字符  ', [
              \['i', '制表符 → 空格 ' , ":s/\t/\\=repeat(' ',\&ts)/g\<cr>"],
              \['l', '消除空行      ' , ":g/^$/del\<cr>"],
              \['s', '消除行尾空白  ' , printf(':s/\s*%s*$%s',"\<c-v>\<c-m>","\<cr>")],
              \['m', '消除行尾回车符' , ":s/\<c-v>\<c-m>$/\<cr>"]]],
          \[';', '行末加分号' , ':g! /\(\(\/\/.\{-}\)\|[{};]\|\(else\)\)$/norm A;'."\<cr>"]]

let align = [['=', '等号对齐', ":Tabularize /=\<cr>"],
           \ [':', '冒号对齐', ":Tabularize /:\<cr>"],
           \ [',', '逗号对齐', ":Tabularize /,\<cr>"],
           \ ['e', '其他对齐', ":Tabularize /"]]
let hex = [['b', '开始编辑' , ":set bin|%!xxd\<cr>"],
          \['e', '结束编辑' , ":%!xxd -r\<cr>"]]
let util = [
        \['l', '打开链接' , 'gx'],
        \['s', '常用替换' , sub],
        \['a', '常用对齐' , align],
        \['h', '十六进制' , hex],
        \['e', '编辑VIMRC', ":e $MYVIMRC\<cr>"],
        \['c', '复制文件名' , ":let @+ = expand('%')\<cr>"]]
if has('win32')
    call extend(util, [
        \['r', '重启GVim   ' , ":sil !start gvim\<cr>:conf qa\<cr>"],
        \['.', '重新打开   ' , ":!start gvim \"%:p\"\<cr>:conf qa\<cr>"],
        \['p', '打开命令行 ' , ":sil exe '!start' &sh\<cr>"],
        \['o', '当前文件夹 ' , ":!start explorer \"%:p:h\"\<cr>"]])
endif
call popup#add('util', 'Util', util)
call popup#add('util-v', 'Util',
    \['r', '替换所选' , 'y:%s/\V\<'."\<c-r>".'"\>/'],
    \['f', '查找所选' , 'y/\V'."\<c-r>\""],
    \['w', '全词查找' , 'y/\V\<'."\<c-r>".'"\>'],
    \['t', '有道词典' , "y:YouDao \<c-r>\"\<cr>"],
    \['b', '百度搜索' , "y:Baidu \<c-r>\"\<cr>"],
    \['x', '执行VimL' , "y:exe @\"\<cr>"],
    \['a', '常用对齐' , align],
    \['s', '常用替换' , sub])

nnoremap <expr><space>  Popup('util')
vnoremap <expr><space>  Popup('util-v')
