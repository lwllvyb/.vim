if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

setl conceallevel=0
setl shiftwidth=2

nnoremap <buffer> j gj
nnoremap <buffer> k gk
nnoremap <buffer> 0 g0
nnoremap <buffer> $ g$

nmap <buffer> <silent> <F3> :Toc<cr>
nmap <buffer> <silent> <F4> :TableFormat<cr>

call popup#add('markdown-jump', {'name': '跳转', 'item': [
    \['n', "\<Plug>Markdown_MoveToNextHeader",              '下一个标题'],
    \['p', "\<Plug>Markdown_MoveToPreviousHeader",          '上一个标题'],
    \['.', "\<Plug>Markdown_MoveToCurHeader",               '当前标题'],
    \['a', "\<Plug>Markdown_MoveToParentHeader",            '父级标题'],
    \['j', "\<Plug>Markdown_MoveToNextSiblingHeader",       '下一个同级标题'],
    \['k', "\<Plug>Markdown_MoveToPreviousSiblingHeader",   '上一个同级标题'],
    \]})

nmap <buffer><expr><m-m> popup#popup('markdown-jump')

"indent
noremap <buffer> <m-i>> I><space><esc>
noremap <buffer> <m-i>- I-<space><esc>
noremap <buffer> <m-i>+ I+<space><esc>
noremap <buffer> <m-i>* I*<space><esc>

inoremap <buffer> <m-;> <!----><c-o>2h
inoremap <buffer> <m-l> [](#)<left>
inoremap <buffer> <m-i> <span id=""><Left><Left>
nnoremap <buffer><silent> <m-i> "tye/<span id="t"><cr>

for i in range(1, 6)
    exe printf('inoremap <buffer> <m-%d> <home>%s<space>', i, repeat('#', i))
endfor

fun! s:tab()
    return (getline('.') =~ '^\s*|' ? "\<ESC>:TableTab\<CR>" : "\t")
endf
imap <buffer><expr><tab> <SID>tab()

com! -buffer TableTab call mdutil#formatTable()
com! -buffer GeneDocx write|!pandoc -f markdown -t docx %:p -o %:p:r.docx
com! -buffer GeneHtml write|!pandoc -f markdown -t html %:p -o %:p:r.html
