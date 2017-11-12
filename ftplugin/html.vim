
setl iskeyword+=-
setl sts=2 sw=2 ts=2

nnoremap <buffer><silent><F5> :up<cr>:call open#(expand('%'))<cr>
imap <buffer><silent><F5> <esc><F5>

if exists('g:popup_loaded')
    if !exists('s:popup_menu')
        let s:popup_menu = pmenu#new('Edit',
                    \ ['f', 'Fold Tag', 'zfat'],
                    \ ['r', 'Replace Tag', 'cstt']).merge(pmenu#edit#n())
    endif

    let b:popup_menus = {'edit': {->s:popup_menu}}
endif
