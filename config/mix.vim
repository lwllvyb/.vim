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
