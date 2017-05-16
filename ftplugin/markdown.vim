set wrap bri cole=0 fdl=3

if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

setl sw=2 ts=2

nnoremap <buffer> j gj
nnoremap <buffer> k gk
nnoremap <buffer> 0 g0
nnoremap <buffer> $ g$

imap <buffer> <m-1> #<space>
imap <buffer> <m-2> ##<space>
imap <buffer> <m-3> ###<space>
imap <buffer> <m-4> ####<space>
imap <buffer> <m-5> #####<space>
imap <buffer> <m-6> ######<space>

vmap <buffer><silent>   <m-q> :s/.*/> &<cr>:noh<cr>
vmap <buffer><silent>   <m-l> :s/.*/* &<cr>:noh<cr>
vmap <buffer><silent>   <m-b> s****<esc>hP
vmap <buffer><expr>     <m-c> mode()==#'V'? "s```\<cr>```\<esc>P": "s``\<esc>P"
vmap <buffer><silent>   <m-i> s__<esc>P

call popup#addl('goto', '跳转',
    \['n', '下一个标题  ' , "\<Plug>Markdown_MoveToNextHeader"],
    \['p', '上一个标题  ' , "\<Plug>Markdown_MoveToPreviousHeader"],
    \['.', '当前标题    ' , "\<Plug>Markdown_MoveToCurHeader"],
    \['a', '父级标题    ' , "\<Plug>Markdown_MoveToParentHeader"],
    \['j', '下一同级标题' , "\<Plug>Markdown_MoveToNextSiblingHeader"],
    \['k', '上一同级标题' , "\<Plug>Markdown_MoveToPreviousSiblingHeader"])
call popup#addl('mdutil', 'Util4Markdown',
    \['d', '生成Docx',  "w|!pandoc -f markdown -t docx %:p -o %:p:r.docx"],
    \['h', '生成Html',  "w|!pandoc -f markdown -t html %:p -o %:p:r.html"],
    \['o', '显示Toc ' , ":Toc\<cr>"],
    \['m', '表格对齐' , ":TableFormat\<cr>"],
    \[',', '任务列表' , ":TaskList\<cr>"],
    \['f', '跳转到锚' , "yiw/<span id=\"\<c-r>\"\">"])
nmap <buffer><expr><m-,> Popup('mdutil')

nmap <buffer><F5> :Preview<cr>
imap <buffer><F5> <esc><F5>

com! -buffer Preview MarkdownPreview
com! -buffer TaskList call mdplus#togtask()
