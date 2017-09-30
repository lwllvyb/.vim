" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_profile = 1
" Use smartcase.
let g:deoplete#enable_smart_case = 1
" Sources
let cxx = ['clang', 'member', 'tag', 'around', 'file', 'buffer']
let g:deoplete#sources = {
    \ 'c': cxx, 'cpp': cxx,
    \ 'vim': ['vim', 'member', 'tag', 'around', 'file', 'buffer'],
    \ 'python': ['jedi', 'member', 'tag', 'around', 'file', 'buffer'],
    \ 'javascript': ['tern', 'member', 'tag', 'around', 'file', 'buffer'],
    \ '_': ['buffer', 'around', 'file', 'tag', 'member']
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
inoremap <expr><c-j> deoplete#manual_complete()

autocmd CompleteDone * silent! pclose!
