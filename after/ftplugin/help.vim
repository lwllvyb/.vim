
setl nolist " signcolumn=yes

nnoremap <buffer><cr> <c-]>

if exists('&winhl')
    setl winhl=Normal:NormalHelp
endif

if exists('g:popup')
    call popup#reg('util#n', pmenu#new('Util',
        \ ['o:', 'Show toc', 'call mix#help_toc()'],
    \ ), &ft)
endif
