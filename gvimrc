set imcmdline               "命令行可以输入中文

set guioptions-=l           "禁用滚动条
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m           "禁用菜单栏和工具栏
set guioptions-=T
set guioptions-=e           "禁用GUI标签页
"set visualbell

if has('win32')
    set linespace=0         "行间距
    set guifont=FantasqueSansMono_NF:h12:cANSI:qDRAFT
    set guifontwide=楷体:h13:cANSI:qDRAFT
"    set guifont=DejaVu_Sans_Mono_for_Powerline:h12:cANSI:qDRAFT
"    set renderoptions=type:directx,renmode:5,taamode:1
    so     $VIMRUNTIME/delmenu.vim
    so     $VIMRUNTIME/menu.vim
else
"    set guifont=Fantasque\ Sans\ Mono\ 12
"    set guifontwide=文泉驿微米黑\ 12
endif
