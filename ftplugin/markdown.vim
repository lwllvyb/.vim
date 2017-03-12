if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

setl cole=0 sw=2 fdl=3

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

"imap <buffer><expr><tab> <SID>tab()
fun! s:tab()
    return (getline('.') =~ '^\s*|' ? "\<ESC>:TableTab\<CR>" : "\t")
endf

com! -buffer TableTab call mdutil#formatTable()
