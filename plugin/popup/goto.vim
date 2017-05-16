scripte utf-8
call popup#add('goto', '跳转',
    \['f', '函数        ', ""],
    \['d', '定义        ', "gd"],
    \['p', '上个函数    ', "[["],
    \['n', '下个函数    ', "]]"])

nmap <expr><m-g> Popup('goto')
