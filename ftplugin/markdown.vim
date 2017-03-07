if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

setl cole=0 sw=2 fdl=3

nnoremap <buffer> j gj
nnoremap <buffer> k gk
nnoremap <buffer> 0 g0
nnoremap <buffer> $ g$

call popup#add('markdown-j', '跳转到',
    \['n', '下一个标题  ' , "\<Plug>Markdown_MoveToNextHeader"],
    \['p', '上一个标题  ' , "\<Plug>Markdown_MoveToPreviousHeader"],
    \['.', '当前标题    ' , "\<Plug>Markdown_MoveToCurHeader"],
    \['a', '父级标题    ' , "\<Plug>Markdown_MoveToParentHeader"],
    \['j', '下一同级标题' , "\<Plug>Markdown_MoveToNextSiblingHeader"],
    \['k', '上一同级标题' , "\<Plug>Markdown_MoveToPreviousSiblingHeader"])
call popup#add('markdown-n', 'Markdown',
    \['d', '生成Docx',  "w|!pandoc -f markdown -t docx %:p -o %:p:r.docx"],
    \['h', '生成Html',  "w|!pandoc -f markdown -t html %:p -o %:p:r.html"],
    \['o', '显示Toc ' , ":Toc\<cr>"],
    \['m', '表格对齐' , ":TableFormat\<cr>"],
    \['f', '跳转到锚' , "yiw/<span id=\"\<c-r>\"\">"])
call popup#add('markdown-v', 'Markdown',
    \['h', '标题' , [
        \['1', '一级', '# '],
        \['2', '二级', '## '],
        \['3', '三级', '### '],
        \['4', '四级', '#### '],
        \['5', '五级', '##### '],
        \['6', '六级', '###### ']]
    \],
    \['q', '引用' , ":s/.*/> &\<cr>"],
    \['l', '列表' , ":s/.*/* &\<cr>"],
    \['b', '粗体' , "s****\<esc>2hp"],
    \['i', '斜体' , "s**\<left>\<esc>p"])
call popup#add('markdown-i', 'Markdown',
    \['b', '插入粗体' , "****\<left>\<left>"],
    \['i', '插入斜体' , "**\<left>"],
    \['/', '插入注释' , "<!---->\<esc>2h"],
    \['l', '插入链接' , "[]()\<left>"],
    \['a', '插入锚点' , "<span id=\"\">\<esc>2h"])

nmap <buffer><expr><m-,> Popup('markdown-j')
nmap <buffer><expr><m-;> Popup('markdown-n')
vmap <buffer><expr><m-;> Popup('markdown-v')
imap <buffer><expr><m-;> Popup('markdown-i')

imap <buffer> <m-1> #<space>
imap <buffer> <m-2> ##<space>
imap <buffer> <m-3> ###<space>
imap <buffer> <m-4> ####<space>
imap <buffer> <m-5> #####<space>
imap <buffer> <m-6> ######<space>

"imap <buffer><expr><tab> <SID>tab()
fun! s:tab()
    return (getline('.') =~ '^\s*|' ? "\<ESC>:TableTab\<CR>" : "\t")
endf

com! -buffer TableTab call mdutil#formatTable()
