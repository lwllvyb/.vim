
fun! s:search_target()
    if !empty(getbufvar('%', 'debug_prog'))
        return b:debug_prog
    endif
    if exists('b:qrun') && has_key(b:qrun, 'bin')
        return b:qrun.bin
    endif
    throw 'Cannot find the debug target'
endf

fun! s:domap()
    let s:maps = map#store('<F5>', '<F7>', '<F9>', '<F10>', '<F11>')
    nnoremap <F5> :CdbGo<cr>
    nnoremap <F7> :CdbEval<cr>
    nnoremap <F9> :CdbBp<cr>
    nnoremap <F10> :CdbStepOver<cr>
    nnoremap <F11> :CdbStepInto<cr>
endf

fun! s:unmap()
    call map#restore(s:maps)
endf

fun! s:ondata(j, d, e)
    let data = a:d
    if s:state == 'init'
        for line in data
            if line =~# 'Breakpoint\s\+\d\+\s\+hit'
                let s:state = 'break'
            endif
        endfor
    elseif s:state == 'break'
        for line in data
            if line =~# '>\s\+\d\+'                " line number
            endif
        endfor
    endif
endf

let s:job = 0
" cdb's window id
let s:cdbwid = 0
let s:bp_id = 1

sign define Breakpoint text=x texthl=WarningMsg
" Buffer nubmer, line number
fun! s:bpsign(bnr, lnr)
    let id = s:bp_id
    exe 'sign place' id 'line=' . a:lnr 'name=Breakpoint' 'buffer=' . a:bnr
    let s:bp_id += 1
    return id
endf

fun! cdb#start(prog)
    if s:job > 0
        call cdb#quit()
        let s:job = 0
        let s:state = 'close'
    else
        let prog = a:0 && !empty(a:1) ? a:1 : s:search_target()
        let cdb = exists('g:path#cdb') ? g:path#cdb: 'cdb'
        rightbelo winc v
        enew
        call s:domap()
        let s:job = termopen([cdb, '-2', '-lines', prog], {
            \ 'on_exit': {j,code,e->s:unmap()}
        \ })
        if s:job <= 0
            throw 'Open the cdb failure'
        else
            let s:state = 'init'
            let s:cdbwid = win_getid()
            winc p
            call jobsend(s:job, "l+t\r\n")
            call jobsend(s:job, "l+s\r\n")
        endif
    endif
endf

let s:bps = {}
fun! cdb#breakline()
    let f = expand('%')
    let line = line('.')
    let sid = s:bpsign(bufnr('%'), line)
    if has_key(s:bps, sid)
        echo jobsend(s:job, 'bc' . sid . "\r\n")
        exe 'sign unplace' sid
    else
        echo jobsend(s:job, printf("bp%d `%s:%d`\r\n", sid, f, line))
        let s:bps[sid] = [f, line]
    endif
endf

fun! cdb#stepover()
    echo jobsend(s:job, "p\r\n")
endf

fun! cdb#stepinto()
    echo jobsend(s:job, "t\r\n")
endf

fun! cdb#eval(...)
    let expr = a:0 && !empty(a:1) ? a:1 : expand('<cword>')
    echo jobsend(s:job, printf("?? %s\r\n", expr))
endf

fun! cdb#go()
    echo jobsend(s:job, "g\r\n")
endf

fun! cdb#quit()
    echo jobsend(s:job, "q\r\n")
    call jobstop(s:job)
    call win_gotoid(s:cdbwid)
    exe "normal" "a\<cr>"
endf
