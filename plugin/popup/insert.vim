scripte utf-8
call popup#add('insert', '插入', 
    \['t', '插入日期', "\<c-r>=strftime('%Y/%b/%d')\<cr>"],
    \['m', '插入模式行', "vim: set "])
call popup#addl('markdown', 'insert',
    \['b', '插入粗体' , "****\<left>\<left>"],
    \['i', '插入斜体' , "**\<left>"],
    \['s', '插入Task' , "* []\<left>"],
    \['/', '插入注释' , "<!---->\<esc>2h"],
    \['l', '插入链接' , "[]()\<left>"],
    \['a', '插入锚点' , "<span id=\"\">\<esc>2h"])

imap <expr><m-i>    Popup('insert')
