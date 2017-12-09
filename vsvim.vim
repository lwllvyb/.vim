" =============================================================================
" Filename:    vsvim.vim
" Author:      luzhlon
" Date:        2017-11-23
" Description: The configuration for vsvim, link this file to ~/_vsvimrc
" =============================================================================

behave mswin

set autoindent
set backspace=indent,eol,start
set shiftwidth=4
set tabstop=4
set hlsearch                    "高亮所有的查找结果
set ignorecase
set smartcase        "忽略大小写
set incsearch
set laststatus=0
set nosol                       "不跳转到行首
set nowrap
set number                      "显示行号
set scrolloff=2                 "滚动时保留2行
set cursorline
set clipboard=unamed
set cursorline                  "高亮光标所在行
"set statusline=\ %t%{&mod?'*':''}\ %h\ %r\ %=Line:%l\ Col:%c\ [%{&fenc}:%{&ff}]\ 

" Line edit
imap <c-b> <left>
imap <c-f> <right>
imap <c-d> <del>
imap <c-a> <home>
imap <c-e> <end>
cmap <m-f> <s-right>
cmap <m-b> <s-left>

imap <m-f> <c-o>ea
imap <m-b> <c-o>b
imap <m-d> <c-o>cw
" imap <expr><c-k> (col('.')==col('$'))?"\<del>":"\<c-o>D"
imap <c-cr> <c-o>O
imap <c-n> <down>
imap <c-p> <up>
imap <c-c> <esc>

inoremap <m-]> <c-t>
inoremap <m-[> <c-d>
inoremap <m-/> <c-n>
inoremap <m-?> <c-p>
inoremap <m-o> <esc>

nmap <m-J> :cn<cr>
nmap <m-K> :cp<cr>

nmap <m-k> <c-w>k
nmap <m-j> <c-w>j
nmap <m-h> <c-w>h
nmap <m-l> <c-w>l

nnoremap <c-p> :vsc Edit.GotoFile<cr>
inoremap <c-j> <esc>:vsc Edit.ListMembers<cr>a

" Use CTRL-S for saving, also in Insert mode
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>

" CTRL-Z is Undo; not in cmdline though
noremap <C-Z> u
inoremap <C-Z> <C-O>u

" CTRL-Y is Redo (although not repeat); not in cmdline though
noremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>		"+gP
" map <S-Insert>		"+gP
imap <C-V>		<Esc>"+gpa

cmap <C-V>		<C-R>+
" cmap <S-Insert>		<C-R>+

nnoremap <c-j> za
nnoremap <c-c><c-c> :conf qa<cr>

nmap <C-O> :vsc View.NavigateBackward<CR>
nmap <esc> :vsc View.NavigateBackward<CR>
nmap <C-I> :vsc View.NavigateForward<CR>

vmap <tab> >gv
vmap <s-tab> <gv
