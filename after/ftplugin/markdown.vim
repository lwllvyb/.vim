
setl wrap breakindent
setl foldlevel=3
setl conceallevel=2 concealcursor=nc
setl nonumber

setl shiftwidth=2 tabstop=2
setl iskeyword=@,48-57,_,128-167,224-235,-
setl matchpairs+=（:）,【:】
setl commentstring=<!--\ %s\ -->

noremap <buffer> <down> gj
noremap <buffer> <up> gk
noremap <buffer> <home> g0
noremap <buffer> <end> g$

inoremap <buffer> <m-2> <home>##<space>
inoremap <buffer> <m-3> <home>###<space>
inoremap <buffer> <m-4> <home>####<space>

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

if exists('g:popup_loaded')
    let b:popup_menus = {
        \ 'goto': 'pmenu#markdown#goto',
        \ 'util': 'pmenu#markdown#util',
        \ 'util-v': 'pmenu#markdown#util_v',
        \ }
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
