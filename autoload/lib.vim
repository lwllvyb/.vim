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
