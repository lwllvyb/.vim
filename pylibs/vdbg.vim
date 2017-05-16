" =============================================================================
" Filename:     pylib/vdbg.vim
" Author:       luzhlon
" Function:     CDB/GDB调试辅助
" Last Change:  2017/3/7
" =============================================================================

py3 from vdbg import CDB, GDB
if has('win32')
    py3 VDbg = CDB
else
    py3 VDbg = GDB
endif

let g:vdbg_bps = {}

com! VDbgBpToggle   call vdbg#BpToggle()
com! VDbgStart      call vdbg#Start()
com! VDbgQuit       call vdbg#Quit()

if !exists('g:vdbg_keymap')
    let g:vdbg_keymap = {}
endif

call extend(g:vdbg_keymap, {
    \ 'cont' : '<F5>',
    \ 'step' : '<F7>',
    \ 'next' : '<F8>',
    \ 'bptg' : '<F9>',
    \ 'quit' : '<S-F5>'
\})
