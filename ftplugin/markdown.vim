
noremap <buffer> <down> gj
noremap <buffer> <up> gk
noremap <buffer> <home> g0
noremap <buffer> <end> g$

inoremap <buffer> <m-2> ##<space>
inoremap <buffer> <m-3> ###<space>
inoremap <buffer> <m-4> ####<space>

" 中文符号映射 {{{
let s:imaps = {'·': '`', '（': '(', '）': ')', '【': '[', '】': ']'}
for [k, v] in items(s:imaps)
    exe 'imap' '<buffer>' k v
endfor
" }}}

" 方便配合鼠标 {{{
vnoremap <buffer><expr> ` mdm#code()
vnoremap <buffer><expr> q mdm#quote()
vnoremap <buffer><expr> <F1> mdm#list()
vnoremap <buffer><expr> <F2> mdm#bold()
" }}}

" 键盘控制 {{{
vnoremap <buffer><expr> <m-1> mdm#list()
vnoremap <buffer><expr> <m-2> mdm#bold()
nnoremap <buffer><expr> # (getline('.')[col('.')-1]=='#'?"I#\<esc>":'#')
" }}} 

if !exists('s:goto_menu')
    let s:goto_menu = [
        \ ['n', 'Next Header', "\<Plug>Markdown_MoveToNextHeader"],
        \ ['p', 'Prev Header', "\<Plug>Markdown_MoveToPreviousHeader"],
        \ ['.', 'Current Header', "\<Plug>Markdown_MoveToCurHeader"],
        \ ['a', 'Parent Header', "\<Plug>Markdown_MoveToParentHeader"],
        \ ['j', 'Next Sibling', "\<Plug>Markdown_MoveToNextSiblingHeader"],
        \ ['k', 'Prev Sibling', "\<Plug>Markdown_MoveToPreviousSiblingHeader"]
    \ ]
    let q = ['q', 'Quote', function('mdm#quote')]
    let b = ['b', 'Bold', function('mdm#bold')]
    let c = ['c', 'Code', function('mdm#code')]
    let l = ['l', 'Smart List', ":call mdm#SmartList()\<cr>"]
    let H = ['H', 'Smart Header', ":call mdm#SmartHeader()\<cr>"]
    let O = ['O', 'Orderd List', ":call mdm#OrderedList()\<cr>"]
    let s:util_menu = [q, b, c, l, H, O,
        \ ['o', 'Toc' , ":Toc\<cr>"],
        \ [',', 'Task', ":call mdplus#togtask()\<cr>"],
        \ ['f', 'Anchor', "yiw/<span id=\"\<c-r>\"\">"]
    \ ]
    let s:util_v = [q, b, c, l, H, O]
    let s:inset_menu = [
        \ ['b', 'Bold', "****\<left>\<left>"],
        \ ['i', 'Italic', "**\<left>"],
        \ ['k', 'Task', "* []\<left>"],
        \ ['/', 'Comment', "<!---->\<esc>2h"],
        \ ['l', 'Link', "[]()\<left>"],
        \ ['a', 'Anchor', "<span id=\"\">\<esc>2h"]
    \ ]
endif

if exists('g:popup_loaded')
    call popup#addl('goto', 'Goto', s:goto_menu)

    call popup#addl('util', 'Markdown utils', s:util_menu)
    call popup#addl('util-v', 'Markdown utils', s:util_v)
    call popup#addl('insert-i', 'Insert', s:inset_menu)

    imap <buffer><expr><m-i> Popup('insert-i')
endif

nmap <buffer><F5> :MarkdownPreview<cr>
imap <buffer><F5> <esc><F5>

com! -buffer GenDocx up | !pandoc -f markdown_github -t docx %:p -o %:p:r.docx
com! -buffer GenHtml up | !pandoc -f markdown_github -t html %:p -o %:p:r.html

let s:tab_cond = {->g:mdm#tab#enable && getline('.')=~'^\s*|'}

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

" if has('gui_running')
"     menu .1 ]MDPopUp.Toc(&t)<tab>:Toc :Toc<cr>
"     menu .1 ]MDPopUp.-Sep- :
"     menu .1 ]MDPopUp.Bold(&b) viws****<ESC>hP
"     menu .1 ]MDPopUp.Code(&c) viws``<ESC>P
"     vnoremenu .1 ]MDPopUp.Bold(&b) s****<ESC>hP
"     vnoremenu .1 ]MDPopUp.Code(&c) s``<ESC>P
"     vnoremenu .1 ]MDPopUp.List(&l) <c-v>0I* <esc>
"     vnoremenu .1 ]MDPopUp.Quote(&q) <c-v>0I> <esc>
"     noremap <silent><buffer> <RightMouse> :<c-u>popup! ]MDPopUp<cr>
" endif
