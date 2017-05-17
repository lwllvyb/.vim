" =============================================================================
" Filename:     autoload/mdplus.vim
" Author:       luzhlon
" Function:     Powerful utils for markdown
" Last Change:  2017/5/17
" =============================================================================
fun! s:gettab()
    if !exists('b:tab')
        let b:tab = {
            \'head': 0, 'tail': 0,
            \'scanline': funcref('s:scanline'),
            \'scan': funcref('s:scan'),
            \'scanall': funcref('s:scanall'),
            \'getline': funcref('s:getline'),
            \'upline': funcref('s:upline'),
            \'fmtline': funcref('s:fmtline'),
            \'fmtall': funcref('s:fmtall'),
            \'format': funcref('s:format'),
            \'curcol': funcref('s:curcol'),
            \'colcol': funcref('s:colcol'),
            \'jump': funcref('s:jump'),
            \'jump2nc': funcref('s:jump2nc'),
            \'intable': funcref('s:intable'),
            \'growto': funcref('s:growto')
        \}
    endif
    return b:tab
endf
fun! mdplus#tab(...)
    let tab = s:gettab()
    call tab.format()
    if tab.jump2nc()
        return
    endif
    let nl = line('.')+1
    call tab.growto(nl)
    call tab.jump(nl, 1)
endf
fun! mdplus#stab(...)
    let tab = s:gettab()
    call tab.format()
    if !tab.jump2nc(-1)
        let nl = line('.')-1
        if tab.intable(nl)
            call tab.jump(nl, tab.width-1)
        endif
    endif
endf
fun! mdplus#cr()
    let tab = s:gettab()
    call tab.format()
    let nl = line('.')+1
    let cc = tab.curcol()
    call tab.growto(nl)
    call tab.jump(nl, cc)
endf
fun! mdplus#scr()
    let tab = s:gettab()
    call tab.format()
    let nl = line('.')-1
    let cc = tab.curcol()
    if tab.intable(nl)
        call tab.jump(nl, cc)
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
" Scan a line, return columns of a line
fun! s:scanline(n) dict
    let ll = split(getline(a:n), '|', 1)
    let self.updated = 0
    if len(ll) > 1          " Split success, it's a table line
        call s:ensurelen(self.colsmax, len(ll))
        let i = 0
        for item in ll
            if !empty(item)
                let item = empty(item) ? '': 
                    \ substitute(item, '^\s*\(.\{-}\)\s*$',' \1 ', '')
                let ll[i] = item
            endif
            " Update column's maximum width info
            let dw = strdisplaywidth(item)
            if dw > self.colsmax[i]
                let self.colsmax[i] = dw
                let self.updated = 1
            endif
            let i += 1
        endfo
        if self.updated
            let self.width = len(self.colsmax)
        endif
        return ll
    endif
    return []
endf
" Scan line from start with direction
fun! s:scan(start, dir) dict
    let lines = []
    let i = a:start
    let ll = self.scanline(i)
    while !empty(ll)
        call add(lines, ll)
        let i += a:dir
        let ll = self.scanline(i)
    endw
    return lines
endf
" Scan a new table
fun! s:scanall() dict
    let curn = line('.')
    let self.colsmax = [0]
    " Scan lines before current
    let lines = reverse(self.scan(curn - 1, -1))
    let self.head = curn - len(lines)
    " Scan lines after current
    let lines += self.scan(curn, 1)
    let self.lines = lines
    let self.width = len(self.colsmax)
    let self.height = len(lines)
    let self.tail = self.head + self.height - 1
endf
" Get items of line n(in buffer)
fun! s:getline(n) dict
    let nl = copy(self.lines[a:n-self.head])
    let j = 0
    for item in nl
        let dw = self.colsmax[j] - strdisplaywidth(item)
        if dw > 0
            let nl[j] .= repeat(' ', dw)
        endif
        let j += 1
    endfo
    while j < self.width
        call add(nl, repeat(' ', self.colsmax[j]))
        let j +=1
    endw
    return nl
endf
" Format line(in buffer) in the table
fun! s:fmtline(n) dict
    call setline(a:n, join(self.getline(a:n), '|'))
endf
" Format the table
fun! s:fmtall() dict
    let i = self.head
    while i <= self.tail
        call self.fmtline(i)
        let i += 1
    endw
endf
" Current column that cursor placed
fun! s:curcol() dict
    let str = strpart(getline('.'), 0, col('.')-1)
    let n = len(split(str, '|', 1))
    return n ? n - 1: 0
endf
" Get column number of table's column in buffer
fun! s:colcol(c, ...) dict
    let col = 2
    let n = a:c
    let l = a:0 ? a:1 : line('.')
    let line = self.getline(l)
    let i = 0
    while i < n
        let col += len(line[i]) + 1
        let i += 1
    endw
    return col
endf
" Update items of line n(in buffer)
fun! s:upline(n) dict
    let self.lines[a:n-self.head] = self.scanline(a:n)
endf
" Format table at line l
fun! s:format(...) dict
    let l = a:0 ? a:1 : line('.')
    if self.intable(l)
        call self.upline(l)
        if self.updated
            call self.fmtall()
        else
            call self.fmtline(l)
        endif
    else
        call self.scanall()
        call self.fmtall()
    endif
endf
" Jump to line x (in buffer) column y (in table)
fun! s:jump(x, y) dict
    let coln = self.colcol(a:y)
    call setpos('.', [bufnr('%'), a:x, coln, 0])
endf
" Jump to next column
fun! s:jump2nc(...) dict
    let c = col('.')
    if c == 1 || c==col('$')-1
        return 0
    endif
    let dir = a:0 ? -1: 1
    let ccol = self.curcol()
    call self.jump(line('.'), ccol+dir)
    return 1
endif
endf
" Check if a line is placed in a table
fun! s:intable(n) dict
    let i = a:n
    while getline(i) =~ '|'
        let i -= 1
    endw
    return self.head == i+1
endf
" Grow tail to line n (in buffer)
fun! s:growto(n) dict
    if a:n == self.tail + 1
        let l = copy(self.colsmax)
        let i = 0
        for w in l
            let l[i] = repeat(' ', w)
            let i += 1
        endfo
        call append(self.tail, join(l, '|'))
        let self.tail += 1
        call add(self.lines, self.scanline(self.tail))
    endif
endf
