" =============================================================================
" Filename:     autoload/mdplus.vim
" Author:       luzhlon
" Function:     Powerful utils for markdown
" Last Change:  2017/5/17
" =============================================================================
let s:tab = {}   " Table Object
fun! mdplus#tab(...)
    if !s:tab.jump2nc()
        let nl = line('.')+1
        if !s:tab.intable(nl)
            call append(nl-1, s:tab.newline())
        endif
        call s:tab.jump(nl, 1)
    endif
endf
fun! mdplus#stab(...)
    if !s:tab.jump2nc(-1)
        let nl = line('.')-1
        if s:tab.intable(nl)
            call s:tab.jump(nl, s:tab.width-1)
        endif
    endif
endf
fun! mdplus#cr()
    let nl = line('.')+1
    let cc = s:tab.curcol()
    call s:tab.format()
    if !s:tab.intable(nl)
        call append(nl-1, s:tab.newline())
    endif
    call s:tab.jump(nl, cc)
endf
fun! mdplus#scr()
    let nl = line('.')-1
    let cc = s:tab.curcol()
    call s:tab.format()
    if s:tab.intable(nl)
        call s:tab.jump(nl, cc)
    endif
endf
" Toggle tasklist
fun! mdplus#togtask()
    let l = matchlist(getline('.'), '^\s*[\*-+]\s\+\[\(.\{-}\)\]')
    if empty(l)
        sil! s/^\s*[\*+-]/& [ ]
    elseif l[1] == 'x'
        s/^\s*[\*-+]\s\+\[\zs.\ze\]/ /
    else
        s/^\s*[\*-+]\s\+\[\zs.\ze\]/x/
    endif
endf
" Ensure that the length of l not less _len
fun! s:ensurelen(l, _len)
    let s = a:_len - len(a:l)
    if s > 0
        call extend(a:l, repeat([0],s))
    endif
endf
" Get lines of table from start with direction 1 or -1
fun! s:getlines(start, dir)
    let n = a:start
    let lines = []
    while 1
        let ll = split(getline(n), '|', 1)
        if len(ll) > 1
            call map(ll, {i,v->empty(v)? v :
            \   substitute(v, '^\s*\(.\{-}\)\s*$',' \1 ', '')})
            call add(lines, ll)
            let n += a:dir
        else|break|endif
    endw
    return lines
endf
" Count width and height, etc.
fun! s:tab.countwc()
    let i = 0
    let colsmax = self['colsmax']
    let lines = self['lines']
    for ll in lines
        call s:ensurelen(colsmax, len(ll))
        let j = 0
        for item in ll
            let dw = strdisplaywidth(item)
            if dw > colsmax[j]
                let colsmax[j] = dw
            endif
            let j += 1
        endfo
        let lines[i] = ll
        let i += 1
    endfo
    let self.colsmax = colsmax
    let self.width = len(colsmax)
    let self.height = len(lines)
endf
" Get table's info
fun! s:tab.getinfo()
    call extend(self, {'width': 0, 'head': 0, 'height': 0, 'colsmax': [0]})
    let cur = line('.')
    let lines = s:getlines(cur, -1)
    if empty(lines) | return | endif
    let lines = reverse(lines)
    let self.head = cur - len(lines) + 1
    call extend(lines, s:getlines(cur+1, 1))
    let self.lines = lines
    call self.countwc()
endf
" Format the table by info
fun! s:tab.format()
    call self.getinfo()
    let colsmax = self['colsmax']
    let i = 0
    while i < self.height
        let line = self.lines[i]
        let j = 0
        for item in line
            let dw = colsmax[j] - strdisplaywidth(item)
            if dw > 0
                let line[j] .= repeat(' ', dw)
            endif
            let j += 1
        endfo
        while j < self.width
            call add(line, repeat(' ', colsmax[j]))
            let j +=1
        endw
        call setline(self.head+i, join(line, '|'))
        let i += 1
    endw
endf
" Current column that cursor placed
fun! s:tab.curcol()
    let str = strpart(getline('.'), 0, col('.')-1)
    let n = len(split(str, '|', 1))
    return n ? n - 1: 0
endf
" Get column number of table's column in buffer
fun! s:tab.colcol(n)
    let col = 2
    let line = self.lines[line('.')-self.head]
    let n = a:n
    let i = 0
    while i < n
        let col += len(line[i]) + 1
        let i += 1
    endw
    return col
endf
" Jump to line x (in buffer) column y (in table)
fun! s:tab.jump(x, y)
    let coln = s:tab.colcol(a:y)
    call setpos('.', [bufnr('%'), a:x, coln, 0])
endf
" Jump to next column
fun! s:tab.jump2nc(...)
    let c = col('.')
    if c == 1 || c==col('$')-1
        return 0
    endif
    let dir = a:0 ? -1: 1
    let ccol = self.curcol()
    call self.format()
    call self.jump(line('.'), ccol+dir)
    return 1
endif
endf
" Jump to next line
fun! s:tab.jump2nl(...)
endf
" Check if a line is placed in a table
fun! s:tab.intable(n)
    let s = a:n - self['head']
    return (s >= 0 && s < self.height)
endf
" Return a empty line string of a table
fun! s:tab.newline()
    let l = copy(self.colsmax)
    let i = 0
    for n in l
        let l[i] = repeat(' ', l[i])
        let i += 1
    endfo
    return join(l, '|')
endf
