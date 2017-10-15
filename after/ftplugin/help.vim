
setl nolist

nnoremap <buffer><cr> <c-]>

if exists('g:popup_loaded')
    call popup#addl('util', 'Help utils', ['o', 'Show toc', ":call mix#help_toc()\<cr>"])
endif
