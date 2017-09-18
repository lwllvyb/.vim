" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_profile = 1
" Use smartcase.
let g:deoplete#enable_smart_case = 1
" let g:deoplete#keyword_patterns = 
" let b:deoplete#keyword_patterns = 
" let g:deoplete#omni_patterns
" let b:deoplete#omni_patterns
" let g:deoplete#ignore_sources
" let b:deoplete#ignore_sources

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

autocmd CompleteDone * silent! pclose!
