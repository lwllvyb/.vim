" =============================================================================
" Filename:    local_.vim
" Author:      luzhlon
" Date:        2017-09-04
" Description: A template for ~/.config/local.vim
" =============================================================================

" About clang_complete
let g:clang_library_path = '...'

if has('win32')
    " About python interepter
    set pythonthreedll=python36.dll
endif

if has('nvim') && has('python3')
    py3 import vim
endif

au VimEnter * nestd colors one | set bg=light
