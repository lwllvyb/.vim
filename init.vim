" =============================================================================
" Filename:    init.vim
" Author:      luzhlon
" Date:        2017-08-28
" Description: startup script for neovim
" =============================================================================

" disable python 2.x
let g:loaded_python_provider = 1
" import vim module for python plugins
if has('python3')
    py3 import vim
endif
" source the common config
sil! so <sfile>:h/vimrc
" config for unix-like system
if has('unix')
    let g:python3_host_prog = '/usr/bin/python3'
endif

" For gonvim {{{
" let g:gonvim_draw_statusline = 0
let g:gonvim_draw_tabline = 0
"}}} 
