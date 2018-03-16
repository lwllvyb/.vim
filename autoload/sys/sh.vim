
let s:path = expand('<sfile>:p:h')

" Run command line {...} with administrator privilige
fun! sys#sh#admin(...)
    call assert_true(len(a:000))
    let params = join(map(a:000[1:], {i,v->shellescape(v)}))
    let input = a:1 . "\n" . params . "\n"
    call system('cscript ' . shellescape(s:path . '\admin-exec.vbs'), input)
endf
