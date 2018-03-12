
if !has_key(g:, 'qrun#dot#path')
    if executable('dot')
        let g:qrun#dot#path = 'dot'
    else
        echom "Please specify the g:qrun#dot#path"
        finish
    endif
endif

fun! qrun#dot#init()
    let b:qrun = {'target': qrun#tempfile('.png')}
endf

fun! qrun#dot#compile(source, target)
    return qrun#compile(printf(
            \ '%s %s -Tpng -o %s',
            \ shellescape(g:qrun#dot#path),
            \ shellescape(a:source),
            \ shellescape(a:target)))
endf

fun! qrun#dot#run()
    return qrun#open(b:qrun['target'])
endf
