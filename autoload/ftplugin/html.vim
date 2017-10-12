
setl iskeyword+=-
setl sts=2 sw=2 ts=2

nnoremap <buffer><silent><F5> :up<cr>:call open#(expand('%'))<cr>
imap <buffer><silent><F5> <esc><F5>

if exists('g:popup_loaded')
    call popup#addl('edit', 'Edit',
        \ ['f', 'Fold Tag', 'zfat'],
        \ ['r', 'Replace Tag', 'cstt'])
endif
