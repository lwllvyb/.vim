" =============================================================================
" Filename:    plugin/mycommand.vim
" Author:      luzhlon
" Date:        2017-08-27
" Description: some useful commands
" =============================================================================
" Echo a dict or list with human readable
com! -nargs=+ -complete=expression Echo call echo#(<args>, 1)
" Show syntax attribute
com! SynAttr echo synIDattr(synID(line('.'), col('.'), 1), 'name')

if has('win32') && has('python3')
    fun! EnableIME(e)
        py3 import ctypes
        py3 imm = ctypes.WinDLL('imm32.dll')
        py3 print(imm.ImmAssociateContext(vim.eval('g:GuiWindowId'), 0))
    endf
    com! IMEDisable call EnableIME(0)
endif
