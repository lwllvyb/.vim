
setl iskeyword+=-
setl sts=2 sw=2 ts=2

nnoremap <buffer><silent><F5> :up<cr>:call open#(expand('%'))<cr>
imap <buffer><silent><F5> <esc><F5>

if !exists('g:popup') || len(popup#menus(&ft))
    finish
endif

call popup#reg('util#n', pmenu#new('Edit',
    \ ['f', 'Fold Tag', 'zfat'],
    \ ['r', 'Replace Tag', 'cstt'],
    \ ['s', 'Substitute', [
        \ ['s', 'Strip', ':s/<\(\w\+\)[^>]*>\(\_.\{-}\)<\/\1>/\2/g'],
        \ ["'", "&nbsp -> '", ":s/&nbsp;/'/g"],
        \ ['b', '<br>', ':s/<br\/\?>/\r/g']]],
\ ), 'html')
