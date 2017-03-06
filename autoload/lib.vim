" =============================================================================
" Filename:     lib.vim
" Author:       luzhlon
" Description:  some useful function of vim script
" Last Change:  2017/2/17
" =============================================================================

"以某个高亮输出文本
fun! lib#echohn(h, ...)
    exe 'echoh' a:h
    echon join(a:)
endf
"获取选择的文本
fun! lib#getselect()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&sel == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
endf
" 获取buffer内容
fun! lib#getbuf()
    norm! gg0VG$"-y
    return @-
endf
" 设置buffer内容
fun! lib#setbuf(dat)
    let @- = a:dat
    norm! ggVG"-p
endf
"保存选项
fun! lib#storeopt(...)
    if !a:0| return {}| endif
    let opt = {}
    for k in a:000
        let opt[k] = eval('&g:'.k)
    endfor
    return opt
endf
"恢复选项
fun! lib#restoreopt(opt)
    for k in keys(a:opt)
        let _ = a:opt[k]
        exe 'let &g:'.k '= _'
    endfor
endf

" =======================================================
let s:deep = 0          "递归的深度
fun! s:echopre(...)
    echon repeat('  ', s:deep)
    if a:0|echon join(a:000)|endif
endf
"格式化输出列表和字典
fun! lib#putlist(d)
    let _t = type(a:d)
    if _t == v:t_dict
        echon "{\n"     |let s:deep += 1
        for i in keys(a:d)
            let v = a:d[i]
            call s:echopre(i, ":\t")
            call lib#putlist(v)|echon ",\n"
        endfo
        let s:deep -= 1 |call s:echopre()|echon "}"
    elseif _t == v:t_list
        echon "[\n"     |let s:deep += 1
        for i in a:d
            call s:echopre()
            call lib#putlist(i)|echon ",\n"
        endfo
        let s:deep -= 1 |call s:echopre()|echon "]"
    else    |echon a:d  |endif
endf
"设置全局默认值
fun! lib#letg(d)
    for [k, v] in items(a:d)
        if !has_key(g:, k)
            let g:[k] = v
        endif
    endfo
endf
