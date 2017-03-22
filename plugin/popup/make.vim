call popup#add('make', '构建',
    \['b', 'XMake构建' , ":XMake\<cr>"],
    \['r', '构建&运行' , ":XMake run\<cr>"],
    \['c', 'XMake清理' , ":XMake clean\<cr>"])

nmap <expr><silent><m-m> Popup('make')
