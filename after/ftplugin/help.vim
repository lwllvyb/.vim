
setl nolist

nnoremap <buffer><cr> <c-]>

if exists('g:popup')
    call popup#reg('util#n', pmenu#new('Util',
        \ ['o:', 'Show toc', 'call mix#help_toc()'],
    \ ), &ft)
endif
