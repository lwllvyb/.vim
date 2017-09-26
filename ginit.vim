" =============================================================================
" Filename:    ginit.vim
" Author:      luzhlon
" Date:        2017-08-28
" Description: For neovim-qt
" =============================================================================

try
GuiFont! FantasqueSansMono NF:h12
call GuiWindowMaximized(1)
catch
    echom v:errmsg
endt

set title
set mouse=a

do GUIEnter *
