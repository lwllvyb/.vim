" =============================================================================
" Filename:     autoload/vdbg.vim
" Author:       luzhlon
" Function:     GDB辅助调试
" Last Change:  2017/3/7
" =============================================================================

let s:map_rhs = {
    \ 'cont' : ':py3 vdbg.cont()<cr>',
    \ 'step' : ':py3 vdbg.step()<cr>',
    \ 'next' : ':py3 vdbg.next()<cr>',
    \ 'bptg' : ':VDbgBpToggle<cr>',
    \ 'quit' : ':VDbgQuit<cr>'
\}

au! VimLeavePre * VDbgQuit

fun! s:onread(d)
    cadde split(a:d, "\n", 1)
    cbottom
endf
fun! s:onquit(code)
    cclose
endf

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
"返回断点列表
fun! vdbg#BpList()
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
    call s:LoadMap()
    copen
    py3 vdbg = VDbg(vim.eval('target'))
    let pid = py3eval('vdbg.pid')
    call proc#onread(pid, funcref('s:onread'))
    call proc#onquit(pid, funcref('s:onquit'))
endf
fun! vdbg#Quit()
    py3 vdbg.quit()
endf
fun! vdbg#Exec(cmd)
    call log#info(a:cmd)
    py3 vdbg.exec(vim.eval('a:cmd'))
endf

let s:keymap = {}       "origin keymap
fun! s:LoadMap()
    for [k, key] in items(g:vdbg_keymap)
        let rhs = maparg(key, 'n')
        if !empty(rhs)
            let s:keymap[key] = rhs
        endif
        exe 'nnoremap' key s:map_rhs[k]
    endfo
endf
fun! s:UnloadMap()
    for [k, key] in items(g:vdbg_keymap)
        if has_key(s:keymap, key)
            exe 'nnoremap' key s:keymap[key]
        else
            exe 'nunmap' key
        endif
    endfo
endf
