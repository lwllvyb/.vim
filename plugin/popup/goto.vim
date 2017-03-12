call popup#add('goto', '跳转',
    \['f', '函数        ', ""],
    \['d', '定义        ', "gd"],
    \['p', '上个函数    ', "[["],
    \['n', '下个函数    ', "]]"])
call popup#addl('vim', 'goto',
    \['f', '函数        ', "\<Plug>(GoToVimFun)"],
    \['d', '定义        ', "\<Plug>(GoToVimLet)"])
call popup#addl('python', 'goto',
    \['f', '函数        ', "\<Plug>(GoToPyDef)"])
call popup#addl('markdown', 'goto',
    \['n', '下一个标题  ' , "\<Plug>Markdown_MoveToNextHeader"],
    \['p', '上一个标题  ' , "\<Plug>Markdown_MoveToPreviousHeader"],
    \['.', '当前标题    ' , "\<Plug>Markdown_MoveToCurHeader"],
    \['a', '父级标题    ' , "\<Plug>Markdown_MoveToParentHeader"],
    \['j', '下一同级标题' , "\<Plug>Markdown_MoveToNextSiblingHeader"],
    \['k', '上一同级标题' , "\<Plug>Markdown_MoveToPreviousSiblingHeader"])

nmap <expr><m-g> Popup('goto')
