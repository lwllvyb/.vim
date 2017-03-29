set wrap cole=0 fdl=3

if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

setl sw=2

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

fun! s:hyphenCount() 
    let prevline = getline(line('.') - 1)
    if !empty(prevline)
        let n = match(prevline, '-[^-]*$')
        return n < 0 ? 0: n - col('.') + 2
    endif
    return 0
endf
fun! s:TAB()
    let l = lib#curstr()
    if l =~ '-$'            " 和上一行的----对齐
        let n = s:hyphenCount()
        return n ? repeat('-', n) : "\<tab>"
    else
        return "\<tab>"
    endif
    "return (getline('.') =~ '^\s*|' ? "\<ESC>:TableTab\<CR>" : "\t")
endf

imap <buffer><expr><tab> <SID>TAB()
com! -buffer TableTab call mdutil#formatTable()
