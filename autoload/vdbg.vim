" =============================================================================
" Filename:     autoload/vdbg.vim
" Author:       luzhlon
" Function:     GDB辅助调试
" Last Change:  2017/2/09
" =============================================================================

"TODO:
"    解决out buffer不能自动滚动的bug
"    询问Y/N时自动选择Y的bug

fun! s:out(ch, msg)
py3 << EOF
b = vim.buffers[int(vim.eval('s:buf'))]
l = vim.eval('a:msg').split('\n')
n = len(b)
b[n-1] = b[n-1] + l.pop(0) 
b.append(l, n)
EOF
endf
let s:op = {
      \ 'in_mode': 'raw',
      \ 'out_mode': 'raw',
      \ 'err_mode': 'raw',
      \ 'out_cb': function('s:out')}
"设置要调试的二进制程序
fun! vdbg#setbin(bin)
    let s:bin = a:bin
endf
"启动调试器
fun! vdbg#start()
    bot vs ene!
    set buftype=nowrite
    set bufhidden=wipe
    set nobl
    let s:buf = bufnr('%')
    winc p
    let s:job = job_start('gdb '.s:bin, s:op)
    let s:ch = job_getchannel(s:job)
endf
"结束调试
fun! vdbg#end()
    call job_stop(s:job)
    exe 'bw '.s:buf
endf
fun! vdbg#exec(cmd)
    let cmd = a:cmd . "\n"
    call ch_sendraw(s:ch, cmd)
    call s:out(0, cmd)
endf
"下断点
fun! vdbg#bp(file, line)
    call vdbg#exec(printf('b %s:%s', a:file, a:line))
endf
"打印变量
fun! vdbg#print(var)
endf
