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
cmap <m-f> <s-right>
cmap <m-b> <s-left>

imap <m-f> <c-c>ea
imap <m-b> <c-o>b
imap <m-d> <c-o>cw
imap <expr><c-k> (col('.')==col('$'))?"\<del>":"\<c-o>D"
imap <c-cr> <c-o>O
imap <c-n> <down>
imap <c-p> <up>

inoremap <m-]> <c-t>
inoremap <m-[> <c-d>
inoremap <m-/> <c-n>
inoremap <m-?> <c-p>
inoremap <m-o> <esc>

nmap <silent> <m-J> :cn<cr>
nmap <silent> <m-K> :cp<cr>
nmap <m-k> <c-w>k
nmap <m-j> <c-w>j
nmap <m-h> <c-w>h
nmap <m-l> <c-w>l
nmap <silent><c-tab> :b!#<cr>

nmap <silent> g. :echo synIDattr(synID(line('.'), col('.'), 1), 'name')<cr>

nnoremap <silent><m-1> :call bufline#(1)<cr>
nnoremap <silent><m-2> :call bufline#(2)<cr>
nnoremap <silent><m-3> :call bufline#(3)<cr>
nnoremap <silent><m-4> :call bufline#(4)<cr>
nnoremap <silent><m-5> :call bufline#(5)<cr>
nnoremap <silent><m-6> :call bufline#(6)<cr>
nnoremap <silent><m-7> :call bufline#(7)<cr>
nnoremap <silent><m-8> :call bufline#(8)<cr>
nnoremap <silent><m-9> :call bufline#(9)<cr>

nnoremap + <c-a>
nnoremap - <c-x>
nnoremap <c-a> ggVG
nnoremap <m-left> <c-o>
nnoremap <m-right> <c-i>
nnoremap <tab> zc
nnoremap <s-tab> zo
nnoremap <silent><c-s> :w<cr>
nnoremap <silent><m-E> :NERDTreeToggle<cr>
nnoremap <c-c><c-c> :conf qa<cr>
noremap <silent><m-/> :Commentary<cr>
noremap <silent><c-f4> :<c-u>QuitBuffer<cr>
noremap <m-$> :norm A
noremap <m-$>: :norm A:<cr>
noremap <m-I> :<c-u>let i=1<cr>gv:g/.*/exe 'norm I'.i.'.'\|let i+=1<cr>

vmap * y/\V\<<c-r>"\>
vmap # y?\V\<<c-r>"\>
vmap g* y/\V<C-R>"
vmap g# y?\V<C-R>"
vmap P p:let @"=@0<cr>
vmap <tab> >gv
vmap <s-tab> <gv
vnoremap <c-x> "+d
vnoremap <c-c> "+y

if has('nvim')
    tnoremap <c-s> <c-\><c-n>
    tnoremap <a-h> <c-\><c-n><c-w>h
    tnoremap <a-l> <c-\><c-n><c-w>l
    tnoremap <a-j> <c-\><c-n><c-w>j
    tnoremap <a-k> <c-\><c-n><c-w>k
endif
