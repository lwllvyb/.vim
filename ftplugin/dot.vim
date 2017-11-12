
fun! s:gen(...)
    update
endf

fun! s:preview()
    let file = fnamemodify(tempname(), ':r') . '.png'
    call s:gen(file)
endf

nnoremap <buffer> <F7> :call <SID>gen()<cr>
imap <buffer> <F7> <esc><F7>
