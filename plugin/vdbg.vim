" =============================================================================
" Filename:     plugin/vdbg.vim
" Author:       luzhlon
" Function:     CDB/GDB调试辅助
" Last Change:  2017/3/6
" =============================================================================

let s:path = expand('<sfile>:h')
py3 import sys; sys.path.append(vim.eval('s:path'))
py3 from process import Process
if has('win32')
    py3 from vdbg import CDB; VDbg = CDB
else
    py3 from vdbg import GDB; VDbg = GDB
endif

let g:vdbg_bps = {}

call lib#letg({
    \ 'vdbg_key_run'  : '<F5>',
    \ 'vdbg_key_step' : '<F7>',
    \ 'vdbg_key_next' : '<F8>',
    \ 'vdbg_key_quit' : '<S-F5>'
\})
"高亮某行
fun! s:hiLine(n)
    if !hlID('Breakpoint')
        hi link Breakpoint ErrorMsg
    endif
    let h = 'bp_'.a:n
    exe 'syn' 'match' h '/\%'.a:n.'l.*/'
    exe 'hi link' h 'Breakpoint'
endf
"取消高亮某行
fun! s:unhiLine(n)
    exe 'syn' 'clear' 'bp_'.a:n
endf
fun! s:bpadd(n)
endf
fun! s:bpclear(n)
endf

fun! s:loadMap()
endf
fun! s:unloadMap()
endf

com! VDbgBpToggle   call vdbg#BpToggle()
com! VDbgStart      call vdbg#Start()
com! VDbgQuit       call vdbg#Quit()
