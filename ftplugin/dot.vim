
fun! s:gen(...)
    update
endf

fun! s:preview()
    let file = fnamemodify(tempname(), ':r') . '.png'
    call s:gen(file)
endf

fun! s:run()
    if !executable('dot')
        echo "Command 'dot' NOT Found"
        return
    endif
    update
    if !exists('b:binfile')
        let b:binfile = fnamemodify(tempname(), ':r') . '.png'
    endif
    let g:RunSuccess = 'sil !' . b:binfile
    if getftime(expand('%')) > getftime(b:binfile)
        exe 'QFRun dot' expand('%') '-Tpng -o' b:binfile
    else
        exe g:RunSuccess
    endif
endf

nnoremap <buffer> <F5> :call <sid>run()<cr>
imap <buffer> <F5> <esc><F5>
nnoremap <buffer> <F7> :call <SID>gen()<cr>
imap <buffer> <F7> <esc><F7>
