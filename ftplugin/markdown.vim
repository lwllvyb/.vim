set wrap bri fdl=3 cole=2

if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

scripte utf-8

setl sw=2 ts=2
setl isk=@,48-57,_,128-167,224-235,-

noremap <buffer> j gj
noremap <buffer> k gk
noremap <buffer> 0 g0
noremap <buffer> $ g$
noremap <buffer> gj j
noremap <buffer> gk k
noremap <buffer> g0 0
noremap <buffer> g$ $

inoremap <buffer> <m-2> ##<space>
inoremap <buffer> <m-3> ###<space>
inoremap <buffer> <m-4> ####<space>
imap <buffer> · `
imap <buffer> （ (
imap <buffer> ） )
vnoremap <buffer><expr> ` mdm#code()
vnoremap <buffer><expr> q mdm#quote()
vnoremap <buffer><expr> <m-1> mdm#list()
vnoremap <buffer><expr> <m-2> mdm#bold()
nnoremap <buffer><expr> # (getline('.')[col('.')-1]=='#'?"I#\<esc>":'#')

if exists('g:popup_loaded')
    call popup#addl('goto', 'Goto',
        \['n', 'Next Header', "\<Plug>Markdown_MoveToNextHeader"],
        \['p', 'Prev Header', "\<Plug>Markdown_MoveToPreviousHeader"],
        \['.', 'Current Header', "\<Plug>Markdown_MoveToCurHeader"],
        \['a', 'Parent Header', "\<Plug>Markdown_MoveToParentHeader"],
        \['j', 'Next Sibling', "\<Plug>Markdown_MoveToNextSiblingHeader"],
        \['k', 'Prev Sibling', "\<Plug>Markdown_MoveToPreviousSiblingHeader"])
    let l = ['l', 'List', function('mdm#list')]
    let q = ['q', 'Quote', function('mdm#quote')]
    let b = ['b', 'Bold', function('mdm#bold')]
    let c = ['c', 'Code', function('mdm#code')]
    call popup#addl('mdutil', 'Markdown', l, q,
        \['o', 'Toc' , ":Toc\<cr>"],
        \[',', 'Task', ":TaskList\<cr>"], b, c,
        \['f', 'Anchor', "yiw/<span id=\"\<c-r>\"\">"])
    call popup#addl('mdutil-v', 'Markdown', l, q, b, c)
    call popup#addl('insert', 'Insert',
        \['b', 'Bold', "****\<left>\<left>"],
        \['i', 'Italic', "**\<left>"],
        \['s', 'Task', "* []\<left>"],
        \['/', 'Comment', "<!---->\<esc>2h"],
        \['l', 'Link', "[]()\<left>"],
        \['a', 'Anchor', "<span id=\"\">\<esc>2h"])

    imap <buffer><expr><m-i> Popup('insert')
    nmap <buffer><expr><m-m> Popup('mdutil')
    vmap <buffer><expr><m-m> Popup('mdutil-v')
endif

nmap <buffer><F5> :MarkdownPreview<cr>
imap <buffer><F5> <esc><F5>

com! -buffer TaskList call mdplus#togtask()
com! -buffer GenDocx up | !pandoc -f markdown -t docx %:p -o %:p:r.docx
com! -buffer GenHtml up | !pandoc -f markdown -t html %:p -o %:p:r.html

let s:tab_cond = {->getline('.')=~'^\s*|' && g:mdm#tab#enable}

call imap#("<tab>", {
    \ 'match': s:tab_cond, 'rhs': "\<c-r>=mdmtab#jump('l')\<cr>"
    \ })
call imap#("<s-tab>", {
    \ 'match': s:tab_cond, 'rhs': "\<c-r>=mdmtab#jump('h')\<cr>"
    \ })
call imap#("<cr>", {
    \ 'match': s:tab_cond, 'rhs': "\<c-r>=mdmtab#jump('j')\<cr>"
    \ })
call imap#("<s-cr>", {
    \ 'match': s:tab_cond, 'rhs': "\<c-r>=mdmtab#jump('k')\<cr>"
    \ })
call imap#("<tab>", {
    \ 'match': '-$', 'rhs': "\<c-r>=align#('-')\<cr>"
    \ })

if has('gui_running')
    menu .1 ]MDPopUp.Toc(&t)<tab>:Toc :Toc<cr>
    menu .1 ]MDPopUp.-Sep- :
    menu .1 ]MDPopUp.Bold(&b) viws****<ESC>hP
    menu .1 ]MDPopUp.Code(&c) viws``<ESC>P
    vnoremenu .1 ]MDPopUp.Bold(&b) s****<ESC>hP
    vnoremenu .1 ]MDPopUp.Code(&c) s``<ESC>P
    vnoremenu .1 ]MDPopUp.List(&l) <c-v>0I* <esc>
    vnoremenu .1 ]MDPopUp.Quote(&q) <c-v>0I> <esc>
    noremap <silent><buffer> <RightMouse> :<c-u>popup! ]MDPopUp<cr>
endif
