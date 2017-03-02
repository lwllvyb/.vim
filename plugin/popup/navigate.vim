call popup#add('navigate-n',
\{'name' : '导航', 'item' : [
    \['k', '上一错误' , ":cp\<cr>"],
    \['j', '下一错误' , ":cn\<cr>"]
\]})
call popup#add('navigate-i',
\{'name' : '导航', 'item' : [
    \['k', '上一行' , "\<up>"],
    \['j', '下一行' , "\<down>"]
\]})

nmap <expr><m-n> Popup('navigate-n')
imap <expr><m-n> Popup('navigate-i')
