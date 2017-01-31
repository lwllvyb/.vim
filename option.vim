set nocompatible
set encoding=utf8
set ruler                       "显示所在的行列号,相关的选项rulerformat statusline paste
set showcmd                     "显示命令输入过程(normal模式里)
"set noerrorbells
set wildmenu                    "命令行补全提示
set list lcs=eol:¬              "设置显示不可见字符
set laststatus=2
"set cmdheight=2                "命令行高度
"set statusline=2
set incsearch
set hlsearch                    "高亮所有的查找结果
set number                      "显示行号
set nobackup                    "不使用备份文件
set noswapfile                  "不使用交换文件
set autoindent                  "自动缩进
set smartindent                 "智能缩进
set autoread                    "自动读入外部更改过的文件
set expandtab                   "扩展tab制表符为空格
set noea                        "不自动设置窗口等宽等高
set scrolloff=2                 "滚动时保留2行
set ignorecase                  "查找时忽略大写小
set smartcase
set nosol                       "不跳转到行首
"set cursorline                  "高亮光标所在行
set fileformats=unix            "unix格式的换行符
set backspace=indent,eol,start  "<BS>键的功能
set clipboard=unnamed           "系统剪贴板对应默认的寄存器
"启动vim时恢复上次关闭的buffer
set viminfo='100,%100,/100,<100,f100
set foldmethod=syntax foldlevel=3
set tabstop=4 softtabstop=4 shiftwidth=4
"set makeprg=xmake

"set cursorcolumn
"set foldmethod=syntax
"set nofoldenable
"set history=128

set background=light
"if has('gui_running')
"    set background=light
"else
"    set background=dark
"    set mouse=a
"endif
