set fdl=6

if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

set sw=4 ts=4

let b:py3 = getline(1) =~ 'python$' ? 0: 1
let b:pyw = 0
let b:ipy = 1

com -buffer Py3Toggle let b:py3 = !b:py3
com -buffer PywToggle let b:pyw = !b:pyw
com -buffer IPyToggle let b:ipy = !b:ipy

fun! s:getcmd()
    let prog = b:pyw ? 'pythonw': (b:ipy ? 'ipython': 'python')
    let opt = prog =~ 'n$' ?
            \ (prog =~ '^i' ? '--no-banner --pdb -i': '-i') : ''
    if b:py3 && prog =~ 'n$' | let prog .= '3' | endif
    return join([prog, opt, '%'])
endf

if exists('g:popup_loaded')
    call popup#addl('goto', '跳转', ['f', '函数', "\<Plug>(GoToPyDef)"])
    " call popup#addl('util', 'Util', ['b', '断点', ])
endif

fun! s:run()
    update
    exe 'QExec' s:getcmd()
endf

nmap <buffer><silent> <F5> :call <SID>run()<cr>
imap <buffer> <F5> <esc><F5>
vnoremap <buffer><m-o> yoprint()<esc>P

call dict#addl('python')
