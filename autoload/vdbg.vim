" =============================================================================
" Filename:     autoload/vdbg.vim
" Author:       luzhlon
" Function:     GDB辅助调试
" Last Change:  2017/2/09
" =============================================================================

"TODO:
"   询问Y/N时自动选择Y的bug

let s:buf = 0
"在特定窗口中执行命令
fun! s:windo(nr, cmd)
    if a:nr > 0
    if a:nr == winnr()
        exe a:cmd
    else
        exe a:nr 'windo ' a:cmd
        winc p
    endif
    endif
endf
"向指定buffer中输出一段文本
fun! s:out2buf(nr, msg)
let l = split(a:msg, "\n", 1)
py3 << EOF
l = vim.eval('l')
b = vim.buffers[int(vim.eval('a:nr'))]
if b:
    n = len(b)
    b[n-1] = b[n-1] + l.pop(0)
    b.append(l, n)
EOF
call s:curh(l)
endf
fun! s:out(ch, msg)
    call s:out2buf(s:buf, a:msg)
    call s:windo(bufwinnr(s:buf), 'norm! G')
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
    if s:buf|retu|endif                "已经打开了一个调试器
    set cursorline
    bot sp ene!
    set buftype=nowrite
    set bufhidden=wipe
    set nobl
    let s:buf = bufnr('%')
    winc p
    let s:job = job_start('gdb -q '.s:bin, s:op)
    let s:ch = job_getchannel(s:job)
endf
"结束调试
fun! vdbg#end()
    call job_stop(s:job)
    exe 'bw '.s:buf
    let s:buf = 0
endf
fun! vdbg#exec(cmd)
    let cmd = a:cmd . "\n"
    call ch_sendraw(s:ch, cmd)
    call s:out(0, cmd)
endf
"下断点
fun! vdbg#bp(file, line)
    call vdbg#exec('b '.a:file.':'.a:line)
endf
"打印变量
fun! vdbg#print(var)
endf
"handler
let s:h = {}

fun! s:h.next(l)
endf

fun! s:h.step(l)
endf

fun! s:h.unkown(l)
    for i in a:l
        let m = matchlist(i, '^Breakpoint\s\+\(\d\+\),.*at\s\+\(.*\):\(\d\+\)')
        if !empty(m)
            let b = m[2]        "断点所在文件的buffer
            let n = m[3]        "断点所在行号
            echo b n
            exe 'b '.b
            exe 'norm! '.n.'G'
            break
        endif
    endfor
endf

"设置当前处理器
fun! s:setcurh(h)
    let s:curh = a:h
endf

call s:setcurh(s:h.unkown)
