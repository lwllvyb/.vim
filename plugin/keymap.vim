" Line edit
noremap! <c-b> <left>
noremap! <c-f> <right>
noremap! <c-d> <del>
noremap! <c-a> <home>
noremap! <c-e> <end>
noremap! <m-f> <s-right>
noremap! <m-b> <s-left>

inoremap <m-d> <c-o>dw
inoremap <expr><c-k> getline('.')==''?'<del>':'<c-o>C'
inoremap <m-j> <down>
inoremap <m-k> <up>

map  <expr><m-.>    popup#last()
map! <expr><m-.>    popup#last()

"nnoremap + <c-a>
"nnoremap - <c-x>
"Tabpage and window
nnoremap <m-k> <c-w>k
nnoremap <m-j> <c-w>j
nnoremap <m-h> <c-w>h
nnoremap <m-l> <c-w>l
"Quickfix
nnoremap <silent> <m-J> :cn<cr>
nnoremap <silent> <m-K> :cp<cr>

vnoremap * y/\V\<<c-r>"\>
vnoremap # y?\V\<<c-r>"\>

if has('nvim')
    tnoremap <c-s> <c-\><c-n>
    tnoremap <a-left> <c-\><c-n><c-w>h
    tnoremap <a-right> <c-\><c-n><c-w>l
    tnoremap <a-down> <c-\><c-n><c-w>j
    tnoremap <a-up> <c-\><c-n><c-w>k
endif
