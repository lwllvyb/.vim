if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

setl conceallevel=0
setl shiftwidth=2

nnoremap <buffer> j gj
nnoremap <buffer> k gk
nnoremap <buffer> 0 g0
nnoremap <buffer> $ g$

call popup#add('markdown-j', {'name': '跳转到', 'item': [
    \['n', '下一个标题  ' , "\<Plug>Markdown_MoveToNextHeader"],
    \['p', '上一个标题  ' , "\<Plug>Markdown_MoveToPreviousHeader"],
    \['.', '当前标题    ' , "\<Plug>Markdown_MoveToCurHeader"],
    \['a', '父级标题    ' , "\<Plug>Markdown_MoveToParentHeader"],
    \['j', '下一同级标题' , "\<Plug>Markdown_MoveToNextSiblingHeader"],
    \['k', '上一同级标题' , "\<Plug>Markdown_MoveToPreviousSiblingHeader"]
\]})
call popup#add('markdown-n', {'name': 'Markdown', 'item': [
    \['d', '生成Docx',  "w|!pandoc -f markdown -t docx %:p -o %:p:r.docx"],
    \['h', '生成Html',  "w|!pandoc -f markdown -t html %:p -o %:p:r.html"],
    \['o', '显示Toc ' , ":Toc\<cr>"],
    \['m', '表格对齐' , ":TableFormat\<cr>"],
    \['f', '跳转到锚' , "yiw/<span id=\"\<c-r>\"\">"]
\]})
call popup#add('markdown-v', {'name': 'Markdown', 'item': [
    \['q', '引用' , "I> \<esc>"],
    \['l', '列表' , "I* \<esc>"],
    \['b', '粗体' , "s****\<esc>2hp"],
    \['i', '斜体' , "s**\<left>\<esc>p"]
\]})
call popup#add('markdown-i', {'name': 'Markdown', 'item': [
    \['1', '一级标题' , "# "],
    \['2', '二级标题' , "## "],
    \['3', '三级标题' , "### "],
    \['4', '四级标题' , "#### "],
    \['5', '五级标题' , "##### "],
    \['6', '六级标题' , "###### "],
    \['/', '插入注释' , "<!---->\<esc>2h"],
    \['i', '插入锚  ' , "[](#)\<left>"],
    \['m', '插入标记' , "<span id=\"\">\<esc>2h"]
\]})

nmap <buffer><expr><m-,> Popup('markdown-j')
nmap <buffer><expr><m-;> Popup('markdown-n')
vmap <buffer><expr><m-;>  Popup('markdown-v')
imap <buffer><expr><m-;> Popup('markdown-i')

fun! s:tab()
    return (getline('.') =~ '^\s*|' ? "\<ESC>:TableTab\<CR>" : "\t")
endf
imap <buffer><expr><tab> <SID>tab()

com! -buffer TableTab call mdutil#formatTable()
