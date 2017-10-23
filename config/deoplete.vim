
let g:deoplete#enable_at_startup = 0
let g:deoplete#enable_profile = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_delay = 50
let g:deoplete#auto_refresh_delay = 100
let g:deoplete#auto_complete_start_length = 1

" Sources
let s:default_sources = ['buffer', 'around', 'file', 'tag', 'member', 'ultisnips']
let s:cxx_sources = has('win32') ? []: ['clang'] + s:default_sources
let g:deoplete#sources = {
    \ '_': s:default_sources, 'c': s:cxx_sources, 'cpp': s:cxx_sources,
    \ 'vim': ['vim'] + s:default_sources,
    \ 'python': ['LanguageClient'] + s:default_sources,
    \ 'javascript': ['tern'] + s:default_sources,
    \ }

" let g:deoplete#keyword_patterns = 
" let b:deoplete#keyword_patterns = 
" let g:deoplete#omni_patterns
" let b:deoplete#omni_patterns
" let g:deoplete#ignore_sources
" let b:deoplete#ignore_sources

" <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><silent><c-j> deoplete#manual_complete()
inoremap <expr><silent><cr> <sid>on_enter()

fun! s:on_enter()
    if !pumvisible() | return "\<cr>" | endif
    let ret = deoplete#close_popup()
    if get(v:completed_item, 'menu', '') =~ '^\[US\]'
        let ret = "\<c-r>=UltiSnips#ExpandSnippet()\<cr>"
    endif
    return ret
endf

autocmd CompleteDone * sil! pclose!

fun! s:on_insert()
    call deoplete#enable()
    sil! au! deoplete InsertEnter
    sil! au! MyInsertEnter InsertEnter
endf

augroup MyInsertEnter
    autocmd InsertEnter * call <sid>on_insert()
augroup END
