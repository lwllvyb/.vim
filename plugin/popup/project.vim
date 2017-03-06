call popup#add('project', '项目',
    \['b', '构建' , ":cp\<cr>"],
    \['c', '清理' , ":cn\<cr>"])

nmap <expr><m-p> Popup('project')
