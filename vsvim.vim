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

nnoremap <c-l> zt

nnoremap <c-p> :vsc 编辑.转到所有<cr>
inoremap <c-j> <esc>:vsc Edit.ListMembers<cr>a

nnoremap <c-g><c-g> <c-g>
nnoremap <c-g><c-h> :vsc 编辑器上下文菜单.代码窗口.切换标题代码文件<cr>
nnoremap <F4> :vsc 编辑器上下文菜单.代码窗口.切换标题代码文件<cr>
nnoremap <c-g><c-s> :vsc 编辑.转到符号<cr>
nnoremap <c-g><c-f> :vsc 编辑.转到文件<cr>

nnoremap gx :vsc 编辑器上下文菜单.代码窗口.打开URL<cr>
nnoremap gf :vsc 编辑.打开文件<cr>
" nnoremap gd :vsc 编辑.转到定义<cr>

" Use CTRL-S for saving, also in Insert mode
nnoremap <c-s>		:w<cr>
inoremap <c-s>		<c-o>:w<cr>

" CTRL-Z is Undo; not in cmdline though
noremap <c-z> u
inoremap <c-z> <c-o>u

" CTRL-Y is Redo (although not repeat); not in cmdline though
noremap <c-y> <c-r>
inoremap <c-y> <c-o><c-r>

" CTRL-A is Select all
noremap <c-a> gggH<c-o>G
cnoremap <c-a> <c-c>gggH<c-o>G
onoremap <c-a> <c-c>gggH<c-o>G
snoremap <c-a> <c-c>gggH<c-o>G
xnoremap <c-a> <c-c>ggVG
" inoremap <c-a> <c-o>gg<c-o>gH<c-o>G

" CTRL-X and SHIFT-Del are Cut
vnoremap <c-x> "+x
vnoremap <s-del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <c-c> "+y
vnoremap <c-insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <c-v>		"+gP
" map <S-Insert>		"+gP
imap <c-v>		<esc>"+gpa
cmap <c-v>		<c-r>+
" cmap <S-Insert>		<C-R>+

nnoremap <c-j> za
nnoremap <c-c><c-c> :conf qa<cr>

nmap <c-o> :vsc View.NavigateBackward<CR>
nmap <esc> :vsc View.NavigateBackward<CR>
nmap <c-i> :vsc View.NavigateForward<CR>

vmap <tab> >gv
vmap <s-tab> <gv
