
if has('nvim')
    set icm=nosplit             " real-time preview for substitute-command
else
    set nocompatible
    set hlsearch                " hilight all the search result
    set incsearch               " hilight the search-result in real time
    set display=lastline        " the display option, about how to render the screen text
    set backspace=indent,eol,start  " the backspace can delete to previous line
    set imdisable

    au CmdwinEnter,InsertEnter * set noimd
    au CmdwinLeave,InsertLeave * set imd
endif

set title                       " show the filename in caption (by default)
set autoindent smartindent
set autoread autowrite
set encoding=utf-8              " internal encoding of vim
set et sw=4 ts=4                " expand tab-character as spaces
set ignorecase smartcase        " ignore the case of letter when search
set confirm                     " show confirm-dialog before quit
set laststatus=1                " show the windows-status on the below-window
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
" set tabline=%!bufline#bufs()
set showtabline=2               " show tabline always
set ffs=unix,dos,mac            " the priority of EOL format
" set fillchars=fold:\ ,vert:\ 
set fillchars=fold:\ ,vert:║
set foldtext=MyFoldText()
" space character
set list lcs=tab:>-,trail:۰,extends:↲,precedes:↳
" set lcs+=eol:¬                  " new line

fun! MyFoldText()
    return getline(v:foldstart) . ' ... ' . 
         \ substitute(getline(v:foldend), '^\s*', '', '')
endf

" set wildmode=longest:full
" set awa aw
" set clipboard=unnamed           " which register that system's clipboard use
" set ambw=double
" set lazyredraw
" set foldmethod=syntax foldlevel=3
" set viminfo='100,%100,/100,<100,f100 " load the MRU files when started vim

" set statusline=\ %t%{&mod?'*':''}\ %h\ %w\ %r\ %=%{&fenc}\|%{&ff}\ %l:%c\ 
" set makeprg=xmake
" set noerrorbells
" set cmdheight=2                 " the height of EX command-line
" set cursorline                  " hilight the cursor line
" set cursorcolumn
" set foldmethod=syntax
" set nofoldenable
" set history=128
" set vbs=1                       " 显示函数、命令、键盘映射等的详细信息
" set complete+=k                 " add the dictionary-completion to default-completions
" set nowrap
" set splitbelow splitright       " Default directions of split
