
let g:neosnippet#enable_completed_snippet = 1
" let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory = expand('<sfile>:h:h') . '/snippets'

" imap <C-\> <Plug>(neosnippet_expand_or_jump)
imap <C-\> <Plug>(neosnippet_expand)
smap <C-\> <Plug>(neosnippet_expand_or_jump)
xmap <C-\> <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
    set conceallevel=2 concealcursor=niv
endif
