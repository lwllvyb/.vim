so <sfile>:h/c-like.vim
nnoremap <buffer><expr><F2> (getline('.')=~'^\s*#include'?
            \ ":YcmCompleter GoToInclude\<cr>": ":YcmCompleter GoToDeclaration\<cr>")
nnoremap <buffer><F3> :YcmCompleter GoToDefinition<cr>
nnoremap <buffer><F4> :call util#ToggleHeader()<cr>
