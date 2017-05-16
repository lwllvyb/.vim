setl complete=.,w,b,u,U,k,s,i,d

fun! s:GenHeaders()
    let h = toupper(expand('%:t'))
    let h = substitute(h, '[^A-Z0-9]', '_', 'g')
    let h = '__' . h . '__'
    norm! ggO
    call setline(1, '#ifndef ' . h)
    call append(1,  '#define ' . h)
    norm! Go
    call setline('$', '#endif /* ' . h . ' */')
endf

nnoremap <buffer><expr><F2> (getline('.')=~'^\s*#include'?
            \ ":YcmCompleter GoToInclude\<cr>": ":YcmCompleter GoToDeclaration\<cr>")
nnoremap <buffer><silent><F3> :YcmCompleter GoToDefinition<cr>
nnoremap <buffer><silent><F4> :call util#ToggleHeader()<cr>
nnoremap <buffer><silent><F5> :call qrun#cxx()<cr>
nnoremap <buffer><silent><m-o> :call qrun#cxx()<cr>

imap <buffer><F5> <esc><F5>
imap <buffer><F4> <esc><F4>

com! -buffer GenHeaders call <SID>GenHeaders()
