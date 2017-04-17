" =============================================================================
" Filename:     autoload/mdutil.vim
" Author:       luzhlon
" Function:     Complete table of markdown
" Last Change:  2017/1/19
" =============================================================================
scripte utf-8
"获取str里pat的数量
fun! s:str_count(str, pat, ...)
    let b = a:0 ? a:1: 0
    let n = 0
    while 1
        let [m, b, e] = matchstrpos(a:str, a:pat, b)
        if b < 0 | break|else
            let n += 1
            let b = e
        endif
    endw
    return n
endf

fun! s:findHead()
    let n = line('.') - 1
    while getline(n) =~ '^\s*|'
        let n -= 1
    endw
    return n + 1
endf

fun! mdutil#formatTable()
    "find table head
    let curline = getline('.')
    let curnr = line('.')
    let headnr = s:findHead()
    "count columns
    let cols = s:str_count(getline(headnr), '|') - 1
    "get current columns
    let curcols = s:str_count(curline, '|') - 1
    let curcol = s:str_count(strcharpart(curline, 0, col('.')), '|')
    "补全剩余的列
    let rest = cols - curcols
    if rest
        exec 'norm ' . rest . "A|\<esc>"
    endif
    TableFormat
    if curcol < cols
    "跳到下一列
        exec 'norm 0'.curcol.'f|l'
    elseif curcol > cols
        norm o
    else
        if getline(curnr+1) =~ '^\s*|'
            "跳到下一行
            norm j0l
        else
            exe "norm! o\<ESC>"
            exe 'norm ' . (cols+1) . "i|\<ESC>"
            TableFormat
        endif
    endif
    startinsert
endf
