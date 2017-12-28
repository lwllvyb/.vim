" =============================================================================
" Filename:    plugin/keymap.vim
" Author:      luzhlon
" Date:        2017-08-27
" Description: ...
" =============================================================================

" Line-Edit && Cursor-Move {{{
map! <c-b> <left>
map! <c-f> <right>
map! <c-d> <del>
map! <c-e> <end>
map! <c-bs> <c-w>
cmap <m-f> <s-right>
cmap <m-b> <s-left>
cmap <c-a> <home>

inoremap <silent><m-f> <c-r>=execute('norm e')<cr><right>
inoremap <silent><m-d> <c-r>=execute('norm dw')<cr>
inoremap <m-b> <c-left>
inoremap <c-n> <down>
inoremap <c-p> <up>
inoremap <silent><expr><c-k> km#del2end()
inoremap <silent><c-a> <c-r>=km#move2first()<cr>
noremap  <expr><silent>0 km#move2first()

nnoremap <expr><c-l> km#redraw()
inoremap <silent><c-l> <c-r>=km#redraw()<cr>

nnoremap gl $
vnoremap gl $h

map <m-;> <Plug>(easymotion-bd-wl)
map <m-n> <Plug>(easymotion-bd-jk)
map <c-k> <Plug>(easymotion-s2)
" }}}

" Completion {{{
inoremap <expr><c-q> pumvisible() ? "\<c-e>": "\<c-q>"
inoremap <expr><silent><cr> km#on_enter()
inoremap <expr><silent><c-j> pumvisible() ? "\<c-n>": deoplete#manual_complete()
inoremap <m-/> <c-n>
" }}}

" Powerful line move {{{
inoremap <silent><m-s-up> <c-r>=km#moveline2up()<cr>
inoremap <silent><m-s-down> <c-r>=km#moveline2down()<cr>
inoremap <c-up> <c-x><c-e>
inoremap <c-down> <c-x><c-y>
" }}}

" Bufline {{{
nnoremap <silent><m-1> :call bufline#(1)<cr>
nnoremap <silent><m-2> :call bufline#(2)<cr>
nnoremap <silent><m-3> :call bufline#(3)<cr>
nnoremap <silent><m-4> :call bufline#(4)<cr>
nnoremap <silent><m-5> :call bufline#(5)<cr>
nnoremap <silent><m-6> :call bufline#(6)<cr>
nnoremap <silent><m-7> :call bufline#(7)<cr>
nnoremap <silent><m-8> :call bufline#(8)<cr>
nnoremap <silent><m-9> :call bufline#(9)<cr>
" }}}

" Window operation {{{
nnoremap <c-w><c-e> <c-w>c
nnoremap <m-j> <c-w>j
nnoremap <m-k> <c-w>k
nnoremap <m-h> <c-w>h
nnoremap <m-l> <c-w>l
" }}}

" Switch file {{{
nnoremap <silent><m-[> :call bufline#prev()<cr>
nnoremap <silent><m-]> :call bufline#next()<cr>
nnoremap <silent><expr>' v:count ? ":Bufline 'split','right'\<cr>": "'"
nnoremap <silent><expr>. v:count ? ":Bufline 'split','below'\<cr>": "."
nnoremap <silent><expr><tab> v:count ? ":Bufline\<cr>": "\<tab>"
nnoremap <silent><c-p> :DeniteProjectDir file_rec<cr>
nnoremap <silent><m-p> :Denite outline<cr>
nnoremap <silent><c-tab> :Denite buffer<cr>
" }}}

" Quickfix {{{
nnoremap <silent><m-J> :cn<cr>
nnoremap <silent><m-K> :cp<cr>
" }}}

" Fold operation {{{
nnoremap <c-j> za
vnoremap <c-j> zf
" }}}

inoremap <m-o> <esc>
nnoremap Q gQ
noremap <expr>K help#map_K()

" F5 -- Run {{{
fun! MyRun()
    if exists('g:xmproj')
        XMake run
    else
        call qrun#()
    endif
endf

noremap <silent><F5> :<c-u>call MyRun()<cr>
imap <silent><F5> <esc><F5>
" }}}

" Select && Edit {{{
" Indent
xnoremap <tab> >gv
xnoremap <s-tab> <gv
inoremap <m-]> <c-t>
inoremap <m-[> <c-d>
" Cut && Copy
vnoremap <c-x> "+d
vnoremap <c-c> "+y
smap <c-x> <c-g><c-x>
smap <c-c> <c-g><c-c>
" Undo && Redo
inoremap <silent><c-z> <c-r>=km#undo()<cr>
inoremap <silent><c-y> <c-r>=km#redo()<cr>
" Paste
inoremap <expr><c-g><c-v> "\<c-o>" . (col('.')==col('$')?'"+gp':'"+gP')
inoremap <silent><c-g><c-p> <c-r>=km#paste()<cr><right>
cnoremap <c-g><c-v> <c-r>+
cnoremap <c-g><c-p> <c-r>"
" Toggle comment
noremap  <silent><m-/> :Commentary<cr>
" Save && Exit
nnoremap <silent><c-s> :update<cr>
nnoremap <silent><c-c><c-c> :conf qa<cr>
nnoremap + <c-a>
nnoremap - <c-x>
noremap <c-a> gggH<c-o>G
" }}}

" Terminal operation {{{
if exists(':tnoremap')
    tnoremap <c-s> <c-\><c-n>
    tnoremap <m-h> <c-\><c-n><c-w>h
    tnoremap <m-l> <c-\><c-n><c-w>l
    tnoremap <m-j> <c-\><c-n><c-w>j
    tnoremap <m-k> <c-\><c-n><c-w>k
endif
" }}}

" Abbreviations {{{
cabbrev baf breakadd func
cabbrev bal breakadd file
cabbrev bah breakadd here
cabbrev brd breakdel

cabbrev chd [一二三四五六七八九十]
"}}} 
