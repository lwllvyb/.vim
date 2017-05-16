
fun! s:OpenCurrent()
    let file = substitute(expand('%:p'), '\\', '/', 'g')
    call browser#get('file://' . file)
endf

com! OpenCurrent call <SID>OpenCurrent()
com! -nargs=* OpenUrl call browser#get(<q-args>)
com! BWQuit call browser#quit()
