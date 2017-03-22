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

nmap <silent> <m-n> :cn<cr>
nmap <silent> <m-N> :cp<cr>
nmap <silent> <m-a> :call ListBuffer()<cr>

cmap <c-cr> <cr>:noh<cr>

nnoremap <silent><m-1> 1gt
nnoremap <silent><m-2> 2gt
nnoremap <silent><m-3> 3gt
nnoremap <silent><m-4> 4gt
nnoremap <silent><m-5> 5gt
nnoremap <silent><m-6> 6gt
nnoremap <silent><m-7> 7gt
nnoremap <silent><m-8> 8gt
nnoremap <silent><m-9> 9gt

"nnoremap + <c-a>
"nnoremap - <c-x>
"Tabpage and window
nnoremap <silent> <m-k> <c-w>k
nnoremap <silent> <m-j> <c-w>j
nnoremap <silent> <m-h> <c-w>h
nnoremap <silent> <m-l> <c-w>l

vnoremap * y/\V\<<c-r>"\>
vnoremap # y?\V\<<c-r>"\>

if has('nvim')
    tnoremap <c-s> <c-\><c-n>
    tnoremap <a-left> <c-\><c-n><c-w>h
    tnoremap <a-right> <c-\><c-n><c-w>l
    tnoremap <a-down> <c-\><c-n><c-w>j
    tnoremap <a-up> <c-\><c-n><c-w>k
endif
