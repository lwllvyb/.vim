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
cnoremap <m-f> <c-r>=km#cmd_forward_word()<cr>
cnoremap <m-b> <c-r>=km#cmd_backward_word()<cr>
cnoremap <expr><m-d> km#cmd_del2wordend()
cnoremap <c-k> <c-\>e strpart(getcmdline(),0,getcmdpos()-1)<cr>
cnoremap <c-a> <home>

inoremap <silent><m-f> <c-r>=execute('norm! e')<cr><right>
inoremap <silent><m-d> <c-r>=execute('norm! dw')<cr>
inoremap <m-b> <c-left>
inoremap <c-n> <down>
inoremap <c-p> <up>
inoremap <m-n> <PageDown>
inoremap <m-p> <PageUp>
inoremap <silent><c-k> <c-r>=km#del2end()<cr>
inoremap <silent><c-a> <c-r>=km#move2first()<cr>
inoremap <silent><c-l> <c-r>=km#redraw()<cr>
inoremap <silent><c-g><c-m> <c-r>=km#normal('M', '!')<cr>
inoremap <silent><c-g><c-h> <c-r>=km#normal('H', '!')<cr>
inoremap <silent><c-g><c-l> <c-r>=km#normal('L', '!')<cr>

noremap  <expr>0     col('.') == 1 ? '^': '0'
xnoremap <expr><c-e> col('.') == col('$') ? 'g_': '$'
nnoremap <expr><c-e> col('.') + 1 == col('$') ? 'g_': '$'
nnoremap <expr><c-l> km#redraw()

map <c-h> <Plug>(easymotion-bd-wl)
map <c-k> <Plug>(easymotion-bd-jk)
map <c-g> <Plug>(easymotion-s)
" }}}

" Completion {{{
inoremap <expr><c-q> pumvisible() ? "\<c-e>": "\<c-q>"
inoremap <expr><silent><cr> km#enter_insert()
inoremap <expr><silent><c-j> pumvisible() ? "\<c-n>": deoplete#manual_complete()
inoremap <m-/> <c-n>
" }}}

" Powerful line move {{{
inoremap <silent><m-s-up> <c-r>=km#normal('ddkP')<cr>
inoremap <silent><m-s-down> <c-r>=km#normal('ddp')<cr>
inoremap <c-up> <c-x><c-e>
inoremap <c-down> <c-x><c-y>
" }}}

" Bufline {{{
nnoremap <silent><m-1> :call bufline#goto(1)<cr>
nnoremap <silent><m-2> :call bufline#goto(2)<cr>
nnoremap <silent><m-3> :call bufline#goto(3)<cr>
nnoremap <silent><m-4> :call bufline#goto(4)<cr>
nnoremap <silent><m-5> :call bufline#goto(5)<cr>
nnoremap <silent><m-6> :call bufline#goto(6)<cr>
nnoremap <silent><m-7> :call bufline#goto(7)<cr>
nnoremap <silent><m-8> :call bufline#goto(8)<cr>
nnoremap <silent><m-9> :call bufline#goto(9)<cr>
" }}}

" Window operation {{{
nnoremap <c-w><c-e> <c-w>c
nnoremap <c-w><c-u> :setl bh=wipe \| close<cr>
nnoremap <m-j> <c-w>j
nnoremap <m-k> <c-w>k
nnoremap <m-h> <c-w>h
nnoremap <m-l> <c-w>l
" }}}

" Switch file {{{
nnoremap <silent><m-i> :call bufline#prev()<cr>
nnoremap <silent><m-o> :call bufline#next()<cr>
nnoremap <silent><expr>' v:count ? ":\<c-u>call bufline#goto(v:count,'right')\<cr>": "'"
nnoremap <silent><expr>. v:count ? ":\<c-u>call bufline#goto(v:count,'below')\<cr>": '.'
nnoremap <silent><expr>o v:count ? ":\<c-u>call bufline#goto(v:count,'above')\<cr>": 'o'
nnoremap <silent><expr><tab> v:count ? ":\<c-u>call bufline#goto(v:count)\<cr>": "\<tab>"
nnoremap <silent><c-p> :DeniteProjectDir file_rec<cr>
nnoremap <silent><m-p> :Denite outline<cr>
nnoremap <silent><c-tab> :Denite buffer<cr>
nnoremap <silent><c-u> :call editor#close_file()<cr>
" }}}

" Quickfix {{{
nnoremap <silent><m-J> :cn<cr>
nnoremap <silent><m-K> :cp<cr>
" }}}

" Fold operation {{{
nnoremap <c-j> za
vnoremap <c-j> zf
" }}}

" Various {{{
inoremap <m-o> <esc>
nnoremap Q gQ
nnoremap <esc> <c-o>
noremap <expr><cr> km#enter_normal()

nnoremap <silent><m-m><m-m> :BookmarkToggle<cr>
nnoremap <silent><m-m><m-n> :BookmarkNext<cr>
nnoremap <silent><m-m><m-p> :BookmarkPrev<cr>
nnoremap <silent><m-m><m-c> :BookmarkClear<cr>

cnoremap ( ()<left>
cnoremap { {}<left>
cnoremap [ []<left>
" }}}

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
map <m-v> <Plug>(expand_region_expand)
map <m-V> <Plug>(expand_region_shrink)
nmap <expr>dq km#delete_quote()
nmap <expr>cq km#change_quote()
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
noremap! <expr><c-g><c-v> km#paste(@+)
noremap! <expr><c-g><c-p> km#paste(@@)
noremap! <expr><c-g>f     km#paste(@%)
noremap! <expr><c-g><c-f> km#paste(expand('%:p'))
noremap! <expr><c-g>d     km#paste(expand('%:h'))
noremap! <expr><c-g><c-d> km#paste(expand('%:p:h'))
" Toggle comment
noremap  <silent><m-/> :Commentary<cr>
" Save && Exit
nnoremap <silent><c-s> :update<cr>
inoremap <silent><c-s> <c-r>=execute('update')?'':''<cr>
nnoremap <silent><c-c><c-c> :conf qa<cr>
nnoremap + <c-a>
nnoremap - <c-x>
" noremap <c-a> gggH<c-o>G
nnoremap <c-a> ggVG
" }}}

" Terminal operation {{{
if exists(':tnoremap')
    tnoremap <m-o> <c-\><c-n>

    fun! s:on_terminal()
        if match(@%, 'cmd\(\.exe\)\?$', 'i') >= 0
            tnoremap <buffer><c-a> <home>
            tnoremap <buffer><c-e> <end>
            tnoremap <buffer><m-b> <c-left>
            tnoremap <buffer><m-f> <c-right>
            tnoremap <buffer><c-b> <left>
            tnoremap <buffer><c-f> <right>
            tnoremap <buffer><c-d> <del>
        endif
    endf

    if has('nvim')
        au TermOpen * call <sid>on_terminal()
    else
        au BufWinEnter * if &bt == 'terminal' | call <sid>on_terminal() | endif
    endif
endif
" }}}

" Visual Search
xnoremap <c-s> y/\V<c-r>"
xnoremap <c-w> y/\V\<<c-r>"\>

" Abbreviations {{{
cabbrev baf breakadd func
cabbrev bal breakadd file
cabbrev bah breakadd here
cabbrev brd breakdel
cnoreabbrev enr echo bufnr('%')
cnoreabbrev lc let @+ =

cnoreabbrev chd [一二三四五六七八九十]
"}}} 
