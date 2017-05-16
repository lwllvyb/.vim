set tabline=%!bufline#()
nnoremap <silent><m-1> :call bufline#(1)<cr>
nnoremap <silent><m-2> :call bufline#(2)<cr>
nnoremap <silent><m-3> :call bufline#(3)<cr>
nnoremap <silent><m-4> :call bufline#(4)<cr>
nnoremap <silent><m-5> :call bufline#(5)<cr>
nnoremap <silent><m-6> :call bufline#(6)<cr>
nnoremap <silent><m-7> :call bufline#(7)<cr>
nnoremap <silent><m-8> :call bufline#(8)<cr>
nnoremap <silent><m-9> :call bufline#(9)<cr>

let s:ccr = []
let s:ctab = [['{$','}'], "\<cr>\<esc>O",
             \'{$', "}\<left>\<cr>\<esc>O",
             \'\.$', "\<c-x>\<c-o>", '::$', "\<c-x>\<c-o>"]
let g:tabmap = {
    \ 'tab': {
        \ '.': "\<tab>", '*': ['\w$', "\<c-n>"],
        \ 'vim': ['\w$', "\<c-x>\<c-v>"],
        \ 'c': s:ctab, 'cpp': s:ctab,
        \ 'javascript': s:ctab, 'java': s:ctab,
        \ 'markdown': ['^\s*|', "\<c-o>:call mdplus#tab()\<cr>",
                      \'-$', "\<c-r>=align#('-')\<cr>"]
    \ },
    \ 'stab': {
        \ '.': "\<s-tab>", '*': ['\w$', "\<c-p>\<c-p>"],
        \ 'markdown': ['^\s*|', "\<c-o>:call mdplus#stab()\<cr>"]
    \ },
    \ 'cr': {
        \ '.': "\<cr>",
        \ 'markdown': ['^\s*|', "\<c-o>:call mdplus#cr()\<cr>"]
    \ },
    \ 'scr': {
        \ '.': "\<s-cr>",
        \ 'markdown': ['^\s*|', "\<c-o>:call mdplus#scr()\<cr>"]
    \ }
\}

inoremap <expr><tab> (pumvisible()?"\<c-n>":tab#key('tab'))
inoremap <expr><s-tab> (pumvisible()?"\<c-p>":tab#key('stab'))
inoremap <expr><cr> tab#key('cr')
inoremap <expr><s-cr> tab#key('scr')
