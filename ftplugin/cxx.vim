setl complete=.,w,b,u,U,k,s,i,d

nnoremap <buffer><expr><F2> (getline('.')=~'^\s*#include'?
            \ ":YcmCompleter GoToInclude\<cr>": ":YcmCompleter GoToDeclaration\<cr>")

nnoremap <buffer><silent><F3> :YcmCompleter GoToDefinition<cr>
nnoremap <buffer><silent><F4> :call cutil#toggleHeader()<cr>
nnoremap <buffer><silent><F5> :call qrun#cxx()<cr>

imap <buffer><F5> <esc><F5>
imap <buffer><F4> <esc><F4>

com! -buffer GenIncMacro call cutil#genIncMacro()
