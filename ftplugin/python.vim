if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

set tabstop=4 "setl foldmethod=indent

let b:py3 = getline(1) =~ 'python$' ? 0: 1

com -buffer UsePy let b:py3 = 0
com -buffer UsePy3 let b:py3 = 1

fun! s:cmd(pycmd)
    return '!'.join([has('win32') ? 'start': '',
                   \ a:pycmd . (b:py3 ? '3': '')])
endf

fun! s:run_ipy()
    let h = &ch| set ch=3
    update
    exe s:cmd('ipython') '--no-banner --pdb -i' '%:p'
    let &ch = h
endf
fun! s:run_py()
    let h = &ch| set ch=3
    update
    exe s:cmd('python') '%:p'
    let &ch = h
endf

nnoremap <buffer> <silent> <F5> :call <SID>run_ipy()<cr>
nnoremap <buffer> <silent> <F6> :call <SID>run_py()<cr>
imap <buffer> <F5> <esc><F5>
imap <buffer> <F6> <esc><F6>

call dict#addl('python')
