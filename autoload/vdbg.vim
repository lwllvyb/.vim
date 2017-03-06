" =============================================================================
" Filename:     autoload/vdbg.vim
" Author:       luzhlon
" Function:     GDB辅助调试
" Last Change:  2017/2/09
" =============================================================================

fun! s:onOutput(d)
    let d = split(a:d, "\n", 1)
py3 << EOF
l = vim.eval('d')
b = vim.buffers[int(vim.eval('s:bufnr'))]
if b:
    n = len(b)
    b[n-1] = b[n-1] + l.pop(0)
    b.append(l, n)
EOF
    redraw
endf

fun! s:onQuit()
endf

py3 << EOF
vdbg = VDbg()
f_on_out = vim.Function('s:onOutput')
f_on_quit = vim.Function('s:onQuit')
vdbg.on_output = lambda p, d: f_on_out(d)
vdbg.on_quit = lambda p: f_on_quit()
EOF

fun! vdbg#BpToggle()
    if !exists('b:bps')
        let b:bps = {}
    endif

    let l = line('.')
    let f = bufname('%')
    let n = bufnr('%')

    if has_key(b:bps, l)
        call s:unhiLine(l)
        unlet b:bps[l]
        "...
    else
        let b:bps[l] = 1
        call s:hiLine(l)
        "...
    endif
endf
fun! s:closeView()
    let wnr = bufwinnr(s:bufnr)
    exe wnr.'winc c'
endf

fun! s:openView()
    "TODO:
    "   映射快捷键
    "   buffer退出时关掉调试器
    bot vs
    if exists('s:bufnr') && bufexists(s:bufnr)
        exe 'b!' s:bufnr
        winc p | return
    endif
    ene! | setl cul bt=nofile bh=hide nobl nowrap
    let s:bufnr = bufnr('%')
    winc p
endf

fun! vdbg#Start()
    "do some checks
    if !exists('g:vdbg_target')
        return
    endif
    let target = g:vdbg_target
    if !filereadable(target)
        echom 'Target is invalid'
        return
    endif
    call s:loadMap()
    call s:openView()
    py3 vdbg.start(vim.eval('target'))
    call s:unloadMap()
endf
fun! vdbg#Quit()
    py3 vdbg.quit()
    call s:closeView()
endf
fun! vdbg#Exec(cmd)
    let cmd = a:cmd
    call s:onOutput(cmd . "\n")
    py3 vdbg.exec(vim.eval('cmd'))
endf

fun! s:bpadd(n)
endf
fun! s:bpclear(n)
endf

fun! s:loadMap()
endf
fun! s:unloadMap()
endf
