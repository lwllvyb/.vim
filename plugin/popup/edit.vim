scripte utf-8
let comment = ['/', '注释' , ":Commentary\<cr>"]
call popup#add('edit', '编辑',
    \['i', '折叠' , "zc"],
    \['o', '展开' , "zo"],
    \['p', '粘贴' , "\"+p"],
    \['a', '全选' , "ggVG"],
    \comment)

call popup#add('edit-v', '编辑',
    \['c', '复制' , "\"+y"],
    \['t', '剪切' , "\"+d"],
    \['p', '粘贴' , "\"+p"],
    \comment)

nmap <expr><m-e> Popup('edit')
vmap <expr><m-e> Popup('edit-v')
