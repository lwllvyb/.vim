scripte utf-8

if has('nvim')
    set icm=nosplit             " real-time preview for substitute-command
else
    set nocompatible
    set autoread
    set hlsearch                " hilight all the search result
    set incsearch               " hilight the search-result in real time
    set display=lastline        " the display option, about how to render the screen text
    set backspace=indent,eol,start  " the backspace can delete to previous line

    au InsertEnter * set noimd
    au InsertLeave * set imd
    au CmdWinEnter * set noimd
    au CmdWinLeave * set imd
endif

set title                       " show the filename in caption (by default)
set autoindent smartindent
set encoding=utf-8              " internal encoding of vim
set et sw=4 ts=4                " expand tab-character as spaces
set ignorecase smartcase        " ignore the case of letter when search
set confirm                     " show confirm-dialog before quit
set laststatus=0                " show the windows-status on the below-window
set nobackup noswapfile         " don't use the backup and swap file
set hidden
set mousehide                   " hide the cursor when typing
set noea                        " don't set same width or height after close a window
set nosol                       " don't goto the first column when press 'gg'
set noshowmode                  " don't show the mode on last line
set number                      " show line number
set ruler                       " show 'ruler' widget, 'rulerformat' specifies the content
set scrolloff=2                 " keep 2 lines when scrolling
set showcmd                     " show the process of keystroke in ruler region
set wildmenu                    " show completion in Ex-mode when type tab
set slm=key,mouse km=startsel   " about Select-mode
set mouse=a                     " use mouse in all mode
set ww+=b,s,[,],<,>,h,l         " move cursor cross lines
set shortmess+=c
set tabline=%!bufline#bufs()
set showtabline=2               " show tabline always
set ffs=unix,dos,mac            " the priority of EOL format
set foldtext=MyFoldText()

fun MyFoldText()
    return getline(v:foldstart) . ' ... ' . 
         \ substitute(getline(v:foldend), '^\s*', '', '')
endf

" set wildmode=longest:full
" set awa aw
" set clipboard=unnamed           " 系统剪贴板对应默认的寄存器
" set ambw=double
" set list lcs=tab:>-,eol:¬       " 设置显示空白字符
" set lazyredraw
" set foldmethod=syntax foldlevel=3
" set viminfo='100,%100,/100,<100,f100 " load the MRU files when started vim

" set statusline=\ %t%{&mod?'*':''}\ %h\ %w\ %r\ %=%{&fenc}\|%{&ff}\ %l:%c\ 
" set makeprg=xmake
" set noerrorbells
" set cmdheight=2                 " 命令行高度
" set cursorline                  " 高亮光标所在行
" set cursorcolumn
" set foldmethod=syntax
" set nofoldenable
" set history=128
" set vbs=1                       " 显示函数、命令、键盘映射等的详细信息
" set complete+=k                 " 默认补全里加上字典补全
" set nowrap
