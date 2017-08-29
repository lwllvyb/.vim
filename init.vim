" =============================================================================
" Filename:    init.vim
" Author:      luzhlon
" Date:        2017-08-28
" Description: For neovim ...
" =============================================================================

let g:loaded_python_provider = 1
so <sfile>:h/vimrc
if has('unix')
    set mouse=a
    let g:python3_host_prog = '/usr/bin/python3'
endif
