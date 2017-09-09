" =============================================================================
" Filename:    init.vim
" Author:      luzhlon
" Date:        2017-08-28
" Description: startup script for neovim
" =============================================================================

let g:loaded_python_provider = 1

if has('python3')
    py3 import vim
endif

so <sfile>:h/vimrc
if has('unix')
    set mouse=a
    let g:python3_host_prog = '/usr/bin/python3'
endif
