set wrap bri cole=0 fdl=3

if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

setl sw=2 ts=2
setl isk=@,48-57,_,128-167,224-235,-

nnoremap <buffer> j gj
nnoremap <buffer> k gk
nnoremap <buffer> 0 g0
nnoremap <buffer> $ g$

inoremap <buffer> <m-2> ##<space>
inoremap <buffer> <m-3> ###<space>
inoremap <buffer> <m-4> ####<space>
inoremap <buffer> <m-5> #####<space>
inoremap <buffer> <m-6> ######<space>
imap <buffer> · `

if exists('g:popup_loaded')
    call popup#addl('goto', '跳转',
        \['n', '下一个标题'   , "\<Plug>Markdown_MoveToNextHeader"],
        \['p', '上一个标题'   , "\<Plug>Markdown_MoveToPreviousHeader"],
        \['.', '当前标题'     , "\<Plug>Markdown_MoveToCurHeader"],
        \['a', '父级标题'     , "\<Plug>Markdown_MoveToParentHeader"],
        \['j', '下一同级标题' , "\<Plug>Markdown_MoveToNextSiblingHeader"],
        \['k', '上一同级标题' , "\<Plug>Markdown_MoveToPreviousSiblingHeader"])
    let l = ['l', 'List', {->(mode()==?'v'?"\<c-v>": '')."0I* \<esc>"}]
    let q = ['q', 'Quote', {->(mode()==?'v'?"\<c-v>": '')."0I> \<esc>"}]
    call popup#addl('mdutil', 'Util4Markdown', l, q,
        \['o', 'Toc' , ":Toc\<cr>"],
        \[',', 'Task', ":TaskList\<cr>"],
        \['b', 'Bold', "viws****\<esc>hP"],
        \['c', 'Code', "viws``\<esc>P"],
        \['f', 'Anchor', "yiw/<span id=\"\<c-r>\"\">"])
    call popup#addl('mdutil-v', 'Util4Markdown', l, q,
        \['b', 'Bold', "s****\<esc>hP"],
        \['c', 'Code', {->mode()==#'V'? "s```\<cr>```\<esc>P": "s``\<esc>P"}])
    call popup#addl('insert', '插入',
        \['b', '插入粗体' , "****\<left>\<left>"],
        \['i', '插入斜体' , "**\<left>"],
        \['s', '插入Task' , "* []\<left>"],
        \['/', '插入注释' , "<!---->\<esc>2h"],
        \['l', '插入链接' , "[]()\<left>"],
        \['a', '插入锚点' , "<span id=\"\">\<esc>2h"])
    nmap <buffer><expr><m-m> Popup('mdutil')
    vmap <buffer><expr><m-m> Popup('mdutil-v')
endif

nmap <buffer><F5> :Preview<cr>
imap <buffer><F5> <esc><F5>

com! -buffer Preview MarkdownPreview
com! -buffer TaskList call mdplus#togtask()
com! -buffer GenDocx up | !pandoc -f markdown -t docx %:p -o %:p:r.docx
com! -buffer GenHtml up | !pandoc -f markdown -t html %:p -o %:p:r.html
