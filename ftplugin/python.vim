set fdl=6

set omnifunc=LanguageClient#complete
set completefunc=LanguageClient#complete

if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

set sw=4 ts=4
set isk&

let b:py3 = getline(1) =~ 'python$' ? 0: 1
let b:pyw = 0
let b:ipy = 1

com -buffer Py3Toggle let b:py3 = !b:py3
com -buffer PywToggle let b:pyw = !b:pyw
com -buffer IPyToggle let b:ipy = !b:ipy

if exists('g:popup_loaded')
    call popup#addl('goto', 'Goto',
                \ ['f', '函数', "\<Plug>(GoToPyDef)"])
    call popup#addl('util', 'Util',
                \ ['p', 'Print', "yiwoprint()\<esc>P"],
                \ ['b', 'BP', ''])
    call popup#addl('util-v', 'Util',
                \ ['p', 'Print', "yoprint()\<esc>P"])
endif

fun! s:run()
    update
    let cmd = join([
                \ b:pyw ? 'pythonw': (b:ipy ? 'ipython': 'python'),
                \ b:pyw ? '': (b:ipy ? '--no-banner --pdb -i': '-i'),
                \ shellescape(expand('%'))
                \ ])
    call qrun#exec(cmd, {'bin': cmd, 'pause': 1})
endf

nmap <buffer><silent> <F5> :call <SID>run()<cr>
imap <buffer> <F5> <esc><F5>

nnoremap <buffer><silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <buffer><silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <buffer><silent> <F2> :call LanguageClient_textDocument_rename()<CR>
