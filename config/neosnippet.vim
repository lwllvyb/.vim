
" let g:neosnippet#enable_completed_snippet = 1
" let g:neosnippet#enable_snipmate_compatibility = 1
" let g:neosnippet#snippets_directory = expand('<sfile>:h:h') . '/snippets'

imap <C-\>  <Plug>(neosnippet_expand_or_jump)
smap <C-\>  <Plug>(neosnippet_expand_or_jump)
xmap <C-\>  <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
fun! s:expand()
    if pumvisible()
        call feedkeys("\<c-n>", 'n') | return ''
    elseif neosnippet#expandable_or_jumpable()
        return "\<Plug>(neosnippet_expand_or_jump)"
    else
        return "\<tab>"
    endif
endf

imap <expr><silent><tab> <sid>expand()
smap <expr><silent><tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)": "\<tab>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
