call popup#add('view', '视图',
    \['e', '文件列表', ":NERDTreeToggle\<cr>"],
    \['n', '消除高亮', ":noh\<cr>"])

nmap <expr><m-v> Popup('view')
