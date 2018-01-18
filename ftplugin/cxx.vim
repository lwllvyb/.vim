
set fdm=syntax fdl=3

" Select a class or struct
xnoremap <buffer> ac ?\<class\>\\|\<struct\><cr><esc>V/{<cr>%
nnoremap <buffer><silent><F4> :call cmode#toggleHeader()<cr>
imap <buffer><F4> <esc><F4>
nmap <buffer>gd <Plug>(clang_complete_goto_declaration)

if !exists('g:popup') || len(popup#menus(&ft))
    finish
endif

fun! s:add_pmenu()
    let menu = pmenu#new('Util',
        \ ['i:', 'Add #include', 'call cmode#add_inc()'],
        \ ['m:', 'GenIncMacro', 'call cmode#genIncMacro()'],
        \ ['h:', 'ToggleHeader', 'call cmode#toggleHeader()'],
        \ ['r', 'Integer -> str', "viw\"-s\<c-r>=ida#int2str(@-)\<cr>"],
    \ )
    if &ft == 'objc'
        call menu.add_item('o:', 'Objective-C', [
            \ ['g:', 'msgSend', 'call ida#objc_msgsend()'],
            \ ['m', 'Method', ':s/\(\w\+\%(\s*\*\)\?\)\s*__\w\+\s\+-\[\w\+\s\+\([:[:alnum:]]\+\)\]\s*([^,]*,[^,]*,\?\s*\([^)]*\))/- (\1) \2(\3)'],
            \ ['s', '@String', ':s/CFSTR(\("[^"]*"\))/@\1/']
        \ ])
    endif
    call popup#reg('util#n', menu, &ft)
endf

call s:add_pmenu()
