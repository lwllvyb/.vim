
let s:origin_buffer = 0
let s:path = expand('<sfile>:h')

fun! pefile#load()
    if exists('b:pefile_loaded') | return | endif
    if 1 == confirm('Load by pefile ?', "&Yes\n&No")
        let s:origin_buffer = bufnr('%')
        let g:pefile#file = expand('%')

        " create a new buffer, prevent vim to load file for current buffer
        exe 'noautocmd' 'e' '[PE] ' . expand('%:t')

        " set bt=nofile
        let b:pefile_loaded = 1
        exe s:origin_buffer 'bw'
        let s:origin_buffer = 0

        set noreadonly
        try
            py3 import pefile
            exe 'py3f' s:path . '/vim-pe.py'
        endt

        setl nomod
        setl binary
        setl foldmethod=indent
        setl foldlevel=0
        " set bt=nofile
        set nomodifiable
        " exe bnr 'bw'
    else
        exe 'noautocmd' 'e' expand('%')
    endif
endf
