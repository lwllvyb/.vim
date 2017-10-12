
" Select a class or struct
vnoremap <buffer> ac ?\<class\>\\|\<struct\><cr><esc>V/{<cr>%
nnoremap <buffer><silent><F4> :call cmode#toggleHeader()<cr>
imap <buffer><F4> <esc><F4>
nmap <buffer>gd <Plug>(clang_complete_goto_declaration)

com! -buffer GenIncMacro call cmode#genIncMacro()

let b:tab_map = {
    \ 'tab': [
        \ ['{$','}'], "\<cr>\<esc>O",
        \ '{$', "}\<left>\<cr>\<esc>O",
        \ '\.$', "\<c-x>\<c-o>", '::$', "\<c-x>\<c-o>"]}

fun! s:stdcin()
    let l = []
    call substitute(@", '\k\+', {m->add(l, m[0])}, 'g')
    let s = printf("ocin >> %s;\<esc>", join(l, '>>'))
    call feedkeys(s, 'n')
endf

fun! s:scanf()
    let l = []
    call substitute(@", '\k\+', {m->add(l, m[0])}, 'g')
    " TODO: type detect
    let type = '%d'
    let s = printf('scanf("%s", %s)', join(repeat([type], len(l))), join(l, ', '))
    call feedkeys('o')
    call feedkeys(s, 'n')
    call feedkeys("\<esc>", 'n')
endf

com! -buffer Scanf call <SID>scanf()
com! -buffer Stdcin call <SID>stdcin()
