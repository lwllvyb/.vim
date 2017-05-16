" =============================================================================
" Filename:     init.vim
" Author:       luzhlon
" Description:  neovim startup script
" Last Change:  2017/2/20
" =============================================================================

let g:loaded_python_provider = 1
so <sfile>:h/vimrc

if has('nvim') && has('unix')
    set mouse=a
    let g:python3_host_prog = '/usr/bin/python3'
endif
