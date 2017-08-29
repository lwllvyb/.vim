
nnoremap <buffer><silent><F4> :call cutil#toggleHeader()<cr>
imap <buffer><F4> <esc><F4>

com! -buffer GenIncMacro call cutil#genIncMacro()

let b:tab_map = {
    \ 'tab': [
        \ ['{$','}'], "\<cr>\<esc>O",
        \ '{$', "}\<left>\<cr>\<esc>O",
        \ '\.$', "\<c-x>\<c-o>", '::$', "\<c-x>\<c-o>"]}
