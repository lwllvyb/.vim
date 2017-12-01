" =============================================================================
" Filename:    vsvim.vim
" Author:      luzhlon
" Date:        2017-11-23
" Description: The configuration for vsvim, link this file to ~/_vsvimrc
" =============================================================================

set autoindent smartindent      "自动缩进、智能缩进
set autoread                    "自动读入外部更改过的文件
set backspace=indent,eol,start  "<BS>键的功能
set display=lastline            "显示不完整的行
set encoding=utf-8
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
set ruler                       "显示所在的行列号,相关的选项rulerformat statusline paste
set scrolloff=2                 "滚动时保留2行
set showcmd                     "显示命令输入过程(normal模式里)
set wildmenu                    "命令行补全提示
set complete+=k                 "默认补全里加上字典补全
set tabline=%!bufline#bufs()
set showtabline=2
set cursorline
set clipboard=unamed
set cursorline                  "高亮光标所在行
"set statusline=\ %t%{&mod?'*':''}\ %h\ %r\ %=Line:%l\ Col:%c\ [%{&fenc}:%{&ff}]\ 

"set noerrorbells
"set foldmethod=syntax

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
imap <expr><c-k> (col('.')==col('$'))?"\<del>":"\<c-o>D"
imap <c-cr> <c-o>O
imap <c-n> <down>
imap <c-p> <up>
imap <c-c> <esc>

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

nnoremap <c-j> za
nnoremap <c-c><c-c> :conf qa<cr>

vmap <tab> >gv
vmap <s-tab> <gv
