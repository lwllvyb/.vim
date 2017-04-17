
nnoremap <silent><m-1> :call bl#select(1)<cr>
nnoremap <silent><m-2> :call bl#select(2)<cr>
nnoremap <silent><m-3> :call bl#select(3)<cr>
nnoremap <silent><m-4> :call bl#select(4)<cr>
nnoremap <silent><m-5> :call bl#select(5)<cr>
nnoremap <silent><m-6> :call bl#select(6)<cr>
nnoremap <silent><m-7> :call bl#select(7)<cr>
nnoremap <silent><m-8> :call bl#select(8)<cr>
nnoremap <silent><m-9> :call bl#select(9)<cr>

let s:ccr = [['{$','}'], "\<cr>\<esc>O",
            \'{$'      , "}\<left>\<cr>\<esc>O"]
let s:ctab = ['\.$', "\<c-x>\<c-o>",
             \'::$', "\<c-x>\<c-o>"]
let g:tabmap = {
    \ 'tab': {
        \ '.': "\<tab>", '*': ['\w$', "\<c-n>"],
        \ 'vim': ['\w$', "\<c-x>\<c-v>"],
        \ 'c': s:ctab, 'cpp': s:ctab,
        \ 'markdown': ['^\s*|', ""]
    \ },
    \ 'stab': {
        \ '.': "\<s-tab>", '*': ['\w$', "\<c-p>\<c-p>"],
        \ 'markdown': ['^\s*|', ""]
    \ },
    \ 'cr': {
        \ '.': "\<cr>",
        \ 'c': s:ccr, 'cpp': s:ccr,
        \ 'javascript': s:ccr, 'java': s:ccr
    \ }
\}

inoremap <expr><tab> (pumvisible()?"\<c-n>":tab#key('tab'))
inoremap <expr><s-tab> (pumvisible()?"\<c-p>":tab#key('stab'))
inoremap <expr><cr> (pumvisible()?"\<c-y>":tab#key('cr'))
