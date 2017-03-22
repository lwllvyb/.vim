let sub = [['x', '斜杠反斜杠', [
              \['x', '反斜杠转义    ' , ':s/\\/\\\\/g'."\<cr>"],
              \['c', '反斜杠消除    ' , ':s/\\\\/\\/g'."\<cr>"],
              \['a', '斜杠 → 反斜杠 ' , ':s/\//\\/g'."\<cr>"],
              \['b', '反斜杠 → 斜杠 ' , ':s/\\/\//g'."\<cr>"]]],
          \['c', '中文标点  ', [
              \['m', '冒号', ":s:/：/:/g\<cr>"],
              \['q', '括号', ":s:/（/(/g\<cr>:s/）/)/g\<cr>"]]],
          \['s', '空白字符  ', [
              \['i', '制表符 → 空格 ' , ":s/\t/\\=repeat(' ',\&ts)/g\<cr>"],
              \['l', '消除空行      ' , ":g/^$/del\<cr>"],
              \['s', '消除行尾空白  ' , ':s/\s\+$'."\<cr>"],
              \['m', '消除行尾回车符' , ":s/\<c-v>\<c-m>$/\<cr>"]]]]
let hex = [['b', '开始编辑' , ":set bin|%!xxd\<cr>"],
          \['e', '结束编辑' , ":%!xxd -r\<cr>"]]
let util = [
        \['l', '打开链接   ' , 'gx'],
        \['s', '常用替换   ' , sub],
        \['h', 'Hex编辑    ' , hex]]
if has('win32')
    call extend(util, [
        \['r', '重启GVim   ' , ":sil !gvim\<cr>:conf qa\<cr>"],
        \['p', '打开命令行 ' , ":!start cmd\<cr>"],
        \['o', '当前文件夹 ' , ":!start explorer \"%:p:h\"\<cr>"]])
endif
call popup#add('util', 'Util', util)
call popup#add('util-v', 'Util',
    \['r', '替换选中' , 'y:%s/\V\<'."\<c-r>".'"\>/'],
    \['f', '查找选中' , 'y/\V'."\<c-r>\""],
    \['w', '全词查找' , 'y/\V\<'."\<c-r>".'"\>'],
    \['t', '有道词典' , "y:YouDao \<c-r>\"\<cr>"],
    \['b', '百度搜索' , "y:Baidu \<c-r>\"\<cr>"],
    \['x', '执行VimL' , "y:exe @\"\<cr>"],
    \['s', '常用替换' , sub])

call popup#addl('markdown', 'util',
    \['m', 'Markdown', [
        \['d', '生成Docx',  "w|!pandoc -f markdown -t docx %:p -o %:p:r.docx"],
        \['h', '生成Html',  "w|!pandoc -f markdown -t html %:p -o %:p:r.html"],
        \['o', '显示Toc ' , ":Toc\<cr>"],
        \['m', '表格对齐' , ":TableFormat\<cr>"],
        \['f', '跳转到锚' , "yiw/<span id=\"\<c-r>\"\">"]]])
call popup#addl('markdown', 'util-v',
    \['m', 'Markdown', [
        \['q', '引用' , ":s/.*/> &\<cr>"],
        \['l', '列表' , ":s/.*/* &\<cr>"],
        \['b', '粗体' , "s****\<esc>2hp"],
        \['c', '代码' , "s```\<cr>```\<esc>P"],
        \['i', '斜体' , "s**\<left>\<esc>p"]]])

nnoremap <expr><space>  Popup('util')
vnoremap <expr><space>  Popup('util-v')
