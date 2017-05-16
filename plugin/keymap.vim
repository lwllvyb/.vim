" =============================================================================
" Filename:     plugin/keymap.vim
" Author:       luzhlon
" Function:     
" Last Change:  2017/3/03
" =============================================================================

" Line edit
map! <c-b> <left>
map! <c-f> <right>
map! <c-d> <del>
map! <c-a> <home>
map! <c-e> <end>
map! <m-f> <s-right>
map! <m-b> <s-left>

imap <m-n> <down>
imap <m-p> <up>
imap <m-j> <PageDown>
imap <m-k> <PageUp>
imap <m-d> <c-o>cw
imap <expr><c-k> (col('.')==col('$'))?"\<del>":"\<c-o>D"
imap <m-o> <esc>
imap <c-cr> <c-o>o
imap <s-cr> <c-o>O

nmap <silent> <m-J> :cn<cr>
nmap <silent> <m-K> :cp<cr>
nmap <silent> <m-a> :call ListBuffer()<cr>
nmap <m-k> <c-w>k
nmap <m-j> <c-w>j
nmap <m-h> <c-w>h
nmap <m-l> <c-w>l
nmap <silent><c-tab> :b!#<cr>

nmap <silent> g. :echo synIDattr(synID(line('.'), col('.'), 1), 'name')<cr>

"nnoremap + <c-a>
"nnoremap - <c-x>

vmap * y/\V\<<c-r>"\>
vmap # y?\V\<<c-r>"\>
vmap g* y/\V<C-R>"
vmap g# y?\V<C-R>"
vmap P p:let @"=@0<cr>
vmap <tab> >gv
vmap <s-tab> <gv

if has('nvim')
    tnoremap <c-s> <c-\><c-n>
    tnoremap <a-h> <c-\><c-n><c-w>h
    tnoremap <a-l> <c-\><c-n><c-w>l
    tnoremap <a-j> <c-\><c-n><c-w>j
    tnoremap <a-k> <c-\><c-n><c-w>k
endif
