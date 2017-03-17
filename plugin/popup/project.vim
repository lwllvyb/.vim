call popup#add('project', '项目',
    \['b', 'XMake构建' , ":XMake\<cr>"],
    \['r', '构建&运行' , ":XMake run\<cr>"],
    \['c', 'XMake清理' , ":XMake clean\<cr>"])

nmap <expr><m-p> Popup('project')
