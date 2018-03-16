
fun! qrun#vb#init()
    let b:qrun = {}
endf

fun! qrun#vb#run()
    return qrun#exec('cscript ' . shellescape(@%))
endf
