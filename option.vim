scripte utf-8
set autoindent smartindent      " 自动缩进、智能缩进
set autoread                    " 自动读入外部更改过的文件
set backspace=indent,eol,start  " <BS>键的功能
set display=lastline            " 显示不完整的行
set encoding=utf-8
set et sw=4 ts=4                " 扩展tab制表符为空格
set hlsearch                    " 高亮所有的查找结果
set ignorecase smartcase        " 忽略大小写
set incsearch
set laststatus=1
set nobackup noswapfile         " 不使用备份、交换文件
set nocompatible
set noea                        " 不自动设置窗口等宽等高
set nosol                       " 不跳转到行首
set nowrap
set number                      " 显示行号
set ruler                       " 显示所在的行列号,相关的选项rulerformat statusline paste
set scrolloff=2                 " 滚动时保留2行
set showcmd                     " 显示命令输入过程(normal模式里)
set wildmenu                    " 命令行补全提示
set complete+=k                 " 默认补全里加上字典补全
set slm=key,mouse km=startsel   " Select模式
set ww+=b,s,[,],<,>,h,l         " 跨行移动光标
set tabline=%!bufline#bufs()
set showtabline=2
set foldtext=FoldText()
set ffs=unix,dos,mac            " 对于空文件优先使用unix换行符

fun! FoldText()
    let start = getline(v:foldstart)
    let end = getline(v:foldend)
    let end = end[match(end, '\S'):]
    return start . ' ... ' . end
endf
" set wildmode=longest:full
" set statusline=\ %t%{&mod?'*':''}\ %h\ %r\ %=Line:%l\ Col:%c\ [%{&fenc}:%{&ff}]\ 
" set awa aw
" set clipboard=unnamed           " 系统剪贴板对应默认的寄存器
" set ambw=double
" set list lcs=tab:>-,eol:¬       " 设置显示空白字符
" set lazyredraw
" set foldmethod=syntax foldlevel=3
" 启动vim时恢复上次关闭的buffer
" set viminfo='100,%100,/100,<100,f100

" set makeprg=xmake
" set noerrorbells
" set cmdheight=2                 " 命令行高度
" set cursorline                  " 高亮光标所在行
" set cursorcolumn
" set foldmethod=syntax
" set nofoldenable
" set history=128
" set vbs=1                       " 显示函数、命令、键盘映射等的详细信息
