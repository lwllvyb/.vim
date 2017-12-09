
" Select a class or struct
vnoremap <buffer> ac ?\<class\>\\|\<struct\><cr><esc>V/{<cr>%
nnoremap <buffer><silent><F4> :call cmode#toggleHeader()<cr>
imap <buffer><F4> <esc><F4>
nmap <buffer>gd <Plug>(clang_complete_goto_declaration)

if exists('g:popup_loaded')
    if !exists('s:popup_menu')
        let s:popup_menu = pmenu#new('Util',
            \ ['i', 'Add #include', ":Include\<cr>"],
            \ ['r', 'Integer -> str', "viw\"-s\<c-r>=ida#int2str(@-)\<cr>"])
        call s:popup_menu.merge(popup#get('util'))
    endif
    let b:popup_menus = {'util': s:popup_menu}
endif

com! -buffer GenIncMacro call cmode#genIncMacro()
com! -buffer -nargs=* Include call cmode#add_inc(<q-args>)
