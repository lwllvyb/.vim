
fun! qrun#dot#init()
    let b:qrun = {'target': qrun#tempfile('.png')}
endf

fun! qrun#dot#compile(source, target)
    return qrun#compile(printf(
            \ 'dot %s -Tpng -o %s',
            \ shellescape(a:source),
            \ shellescape(a:target)))
endf

fun! qrun#dot#run()
    return qrun#open(b:qrun['target'])
endf
