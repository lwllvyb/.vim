
set autoindent smartindent      "自动缩进、智能缩进
set autoread                    "自动读入外部更改过的文件
set backspace=indent,eol,start  "<BS>键的功能
set display=lastline            "显示不完整的行
set encoding=utf-8
set shiftwidth=4
set tabstop=4
set ffs=unix,dos,mac ff=unix    "unix格式的换行符
set hlsearch                    "高亮所有的查找结果
set ignorecase
set smartcase        "忽略大小写
set incsearch
set laststatus=1
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
let &foldtext='(getline(v:foldstart) . " ... " . getline(v:foldend))'
"set statusline=\ %t%{&mod?'*':''}\ %h\ %r\ %=Line:%l\ Col:%c\ [%{&fenc}:%{&ff}]\ 
"set awa aw
"set list lcs=tab:>-,eol:¬       "设置显示空白字符
"set lazyredraw
"set foldmethod=syntax foldlevel=3
"启动vim时恢复上次关闭的buffer
"set viminfo='100,%100,/100,<100,f100

"set makeprg=xmake
"set noerrorbells
"set cmdheight=2                "命令行高度
"set cursorline                  "高亮光标所在行
"set cursorcolumn
"set foldmethod=syntax
"set nofoldenable
"set history=128


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
nnoremap <c-j> za
nnoremap <m-left> <c-o>
nnoremap <m-right> <c-i>
nnoremap <silent><c-s> :w<cr>
nnoremap <silent><m-E> :NERDTreeToggle<cr>
nnoremap <c-c><c-c> :conf qa<cr>

vmap * y/\V\<<c-r>"\>
vmap # y?\V\<<c-r>"\>
vmap g* y/\V<C-R>"
vmap g# y?\V<C-R>"
vmap P p:let @"=@0<cr>
vmap <tab> >gv
vmap <s-tab> <gv
