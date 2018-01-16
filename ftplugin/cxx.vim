
set fdm=syntax fdl=3

" Select a class or struct
xnoremap <buffer> ac ?\<class\>\\|\<struct\><cr><esc>V/{<cr>%
nnoremap <buffer><silent><F4> :call cmode#toggleHeader()<cr>
imap <buffer><F4> <esc><F4>
nmap <buffer>gd <Plug>(clang_complete_goto_declaration)

if !exists('g:popup') || len(popup#menus(&ft))
    finish
endif

call popup#reg('util#n', pmenu#new('Util',
    \ ['i:', 'Add #include', 'call cmode#add_inc()'],
    \ ['m:', 'GenIncMacro', 'call cmode#genIncMacro()'],
    \ ['h:', 'ToggleHeader', 'call cmode#toggleHeader()'],
    \ ['r', 'Integer -> str', "viw\"-s\<c-r>=ida#int2str(@-)\<cr>"]
\), &ft)
