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
noremap! <c-e> <end>
noremap! <m-f> <s-right>
noremap! <m-b> <s-left>

inoremap <m-d> <c-o>diw
inoremap <expr><c-k> getline('.')?'<del>':'<c-o>C'

nmap <m-n> :cn<cr>
nmap <m-N> :cp<cr>
nmap <m-a> :call ListBuffer()<cr>

"nnoremap + <c-a>
"nnoremap - <c-x>
"Tabpage and window
nnoremap <m-k> <c-w>k
nnoremap <m-j> <c-w>j
nnoremap <m-h> <c-w>h
nnoremap <m-l> <c-w>l

vnoremap * y/\V\<<c-r>"\>
vnoremap # y?\V\<<c-r>"\>

if has('nvim')
    tnoremap <c-s> <c-\><c-n>
    tnoremap <a-left> <c-\><c-n><c-w>h
    tnoremap <a-right> <c-\><c-n><c-w>l
    tnoremap <a-down> <c-\><c-n><c-w>j
    tnoremap <a-up> <c-\><c-n><c-w>k
endif
