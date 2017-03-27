" =============================================================================
" Filename:     plugin/keymap.vim
" Author:       luzhlon
" Function:     
" Last Change:  2017/3/03
" =============================================================================

" Line edit
noremap! <c-b> <left>
noremap! <c-f> <right>
noremap! <c-d> <del>
noremap! <c-a> <home>
cnoremap <c-e> <end>
inoremap <expr><c-e> (pumvisible()?"\<c-e>":"\<end>")
noremap! <m-f> <s-right>
noremap! <m-b> <s-left>

inoremap <m-d> <c-o>diw
inoremap <expr><c-k> getline('.')?'<del>':'<c-o>C'

nmap <silent> <m-n> :cn<cr>
nmap <silent> <m-N> :cp<cr>
nmap <silent> <m-a> :call ListBuffer()<cr>

cmap <c-cr> <cr>:noh<cr>

inoremap <c-cr> <c-o>o
inoremap <s-cr> <c-o>O
imap <expr><tab> (pumvisible()?"\<c-n>":"\<tab>")
imap <expr><s-tab> (pumvisible()?"\<c-p>":"\<s-tab>")

"nnoremap + <c-a>
"nnoremap - <c-x>
"Tabpage and window
nnoremap <silent> <m-k> <c-w>k
nnoremap <silent> <m-j> <c-w>j
nnoremap <silent> <m-h> <c-w>h
nnoremap <silent> <m-l> <c-w>l

vmap * y/\V\<<c-r>"\>
vmap # y?\V\<<c-r>"\>
vmap / y/\V<C-R>"
vmap ? y?\V<C-R>"

if has('nvim')
    tnoremap <c-s> <c-\><c-n>
    tnoremap <a-left> <c-\><c-n><c-w>h
    tnoremap <a-right> <c-\><c-n><c-w>l
    tnoremap <a-down> <c-\><c-n><c-w>j
    tnoremap <a-up> <c-\><c-n><c-w>k
endif
