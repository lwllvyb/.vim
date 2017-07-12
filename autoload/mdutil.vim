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
" Format the table in markdown
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fun! s:settableline(edge, mt, lt, rt)
    let n = line('.')
    let up = getline(n - 1)
    let down = getline(n + 1)

    let size = strchars(up)
    let shortn = n + 1
    let sub = strdisplaywidth(up) - strdisplaywidth(down)
    if sub < 0
        let shortn = n - 1
        let size = strchars(down)
    endif
    let origin_short_line = getline(shortn)
    call setline(shortn, origin_short_line . repeat(' ', abs(sub)))
    call setline(n, repeat('─', size))
    norm 0
    let first = 1
    let lastflag = ''
    let lastcol = 0
    let i = 0
    while i < size
        let curcol = i + 1
        let curpos = getpos('.')
        norm! k"ayl
        call setpos('.', curpos)
        norm! j"byl
        call setpos('.', curpos)
        let flag = (@a == a:edge ? 'u': '') . (@b == a:edge ? 'd': '')
        if flag != '' && first
            let first = 0
            exe 'norm!' 'r' . a:lt[flag]
        else
            let lastflag = a:mt[flag]
            let lastcol = getpos('.')
            exe 'norm!' 'r' . lastflag
        endif
        norm! l
        let i += 1
        echo flag
        redraw
    endw
    if !empty(lastflag)
        call setpos('.', lastcol)
        exe 'norm!' 'r' . a:rt[flag]
    endif
    call setline(shortn, origin_short_line)
endf
" Set the table line according the line up and down(WideChar)
fun! mdutil#setTableLineW()
    call s:settableline('│',
        \ {'': '─', 'u': '┴', 'd': '┬', 'ud': '┼'},
        \ {'': '─', 'ud': '├', 'u': '└', 'd': '┌'},
        \ {'': '─', 'ud': '┤', 'u': '┘', 'd': '┐'})
endf
" Set the table line according the line up and down
fun! mdutil#setTableLine()
    call s:settableline('|',
        \ {'': '-', 'ud': '+', 'u': '+', 'd': '+'},
        \ {'': '-', 'ud': '+', 'u': '+', 'd': '+'},
        \ {'': '-', 'ud': '+', 'u': '+', 'd': '+'})
endf
