" =============================================================================
" Filename:     plugin/vdbg.vim
" Author:       luzhlon
" Function:     CDB/GDB调试辅助
" Last Change:  2017/3/6
" =============================================================================

"TODO:
"   在Vim退出时先结束子进程
"   关掉view buffer时结束调试器
"   设置view的statusline为debug
"
py3 from vdbg import CDB, GDB
if has('win32')
    py3 VDbg = CDB
else
    py3 VDbg = GDB
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

com! VDbgBpToggle   call vdbg#BpToggle()
com! VDbgStart      call vdbg#Start()
com! VDbgQuit       call vdbg#Quit()
