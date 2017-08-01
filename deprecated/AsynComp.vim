" ========================================
" FileName: AsynComp.vim
" Author:   luzhlon
" Description: 自动弹出补全框
" ========================================
finish "功能有待加强
fun! s:Complete(c)
    let str = lib#curstr()
    if str =~ '\w\{2,}$'
        call feedkeys("\<c-p>\<down>")
    endif
endf
let s:lastcol = 0
fun! s:Changed()
    let firstcol = col('.')     "记录下当前位置
    if firstcol == s:lastcol
        return
    else
        let s:lastcol = firstcol
    endif
    if s:enable && firstcol > 1
        fun! CheckComp(t) closure
            let column = col('.')
            if column == firstcol && !pumvisible()
                call s:Complete(column)
            endif
        endf
        call timer_start(s:inteval, funcref('CheckComp'))
    endif
endf
au TextChangedI * call <SID>Changed()

let s:timer   = 0
let s:enable  = 1      "是否启用
let s:inteval = 80     "检查间隔(毫秒)
fun! s:ToggleCheck()
    let s:enable = !s:enable
    echo s:enable ? 'Enable' : 'Disable' 'AsynComplete'
endf

com! AsynCompToggle call <SID>ToggleCheck()
