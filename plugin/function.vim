
fun! Run()
    if exists('g:xmproj')
        XMake run
    elseif &ft == 'c' || &ft == 'cpp'
        call qrun#cxx()
    endif
endf

nnoremap <silent><F5> :call Run()<cr>
imap <silent><F5> <ESC><F5>
