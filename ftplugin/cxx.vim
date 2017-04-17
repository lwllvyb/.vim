" 生成防止头文件重包含的预处理语句
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

so <sfile>:h/c-like.vim
nnoremap <buffer><expr><F2> (getline('.')=~'^\s*#include'?
            \ ":YcmCompleter GoToInclude\<cr>": ":YcmCompleter GoToDeclaration\<cr>")
nnoremap <buffer><F3> :YcmCompleter GoToDefinition<cr>
nnoremap <buffer><F4> :call util#ToggleHeader()<cr>

com! -buffer GenHeaders call <SID>GenHeaders()
