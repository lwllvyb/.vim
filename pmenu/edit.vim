
let s:subs = [
        \ ['m', 'C Comment', ':s/\/\/\s*\(.*\)/\/* \1 *\/'],
        \ ['c', 'Width Char', [
            \ ['c', 'Colon', ":s/：/:/g"],
            \ ['b', 'Breakets', ':s/（\(.\{-}\)）/(\1)/g']]],
        \ ['x', 'Count', ":s/\<c-r>//\\=repeat('-', len(submatch(0)))"],
        \ ['s', 'Spaces', [
            \ ["\t", 'Tab -> Space', ":s/\t/\\=repeat(' ',\&ts)/g"],
            \ ["\r", 'Del Empty Line', ":g/^$/del"],
            \ ['s', 'Del End-Spaces', ':s/\s*\r*$']]],
        \ ['/', '// && \\', [
            \ ['x', '\ -> \\', ':s/\\/\\\\/g'],
            \ ['c', '\\ -> \', ':s/\\\\/\\/g'],
            \ ['/', '/ -> \' , ':s/\//\\/g'],
            \ ['\', '\ -> /' , ':s/\\/\//g']]],
        \ [';', 'Add ;' , ':g! /\(\(\/\/.\{-}\)\|[{};]\|\(else\)\)$/norm A;']]

let s:align = ['l', 'Align', ':Tabularize /']
let s:comment = [';', 'Comment' , ":Commentary\<cr>"]
let s:format = ['=', 'Format', ":Neoformat\<cr>"]
let s:subs = ['s!', 'Substitute', s:subs]

call popup#reg('edit#n', pmenu#new('Edit',
    \ ['f', 'Line-format', [
        \ ['d:', 'DOS', 'set ff=dos'],
        \ ['u:', 'UNIX', 'set ff=unix'],
        \ ['m:', 'MAC', 'set ff=mac']]],
    \ ['h', 'Hex-edit', [
        \ ['b:', 'Start' , 'set bin|%!xxd'],
        \ ['e:', 'End' , '%!xxd -r']]],
    \ ['a', 'Select all', "ggVG"],
    \ ['c', 'Copy to clipboard', ':let @+ = '],
    \ ['g', 'Goto', function('popup#', ['edit#goto'])],
    \ ['/', 'Last search', ":s///g\<left>\<left>"],
    \ s:align, s:comment, s:format ,s:subs
\ ))

call popup#reg('edit#goto', pmenu#new('Goto',
    \ ['f', 'Function', ""],
    \ ['d', 'Implentation', "gd"],
    \ ['p', 'Previous', "[["],
    \ ['n', 'Next Function', "]]"]
\ ))

call popup#reg('edit#v', pmenu#new('Edit',
    \ ['e', 'ROT13', 'g?'],
    \ ['c', 'Copy', "\"+y"],
    \ ['t', 'Cut', "\"+d"],
    \ ['p', 'Paste', "\"+p"],
    \ ['i', 'Insert chars', ':norm I'],
    \ ['a', 'Append chars', ':norm A'],
    \ ['R', 'Reverse lines', ":g/^/move \<c-r>=line(\"'<\")-1\<cr> | noh"],
    \ s:align, s:comment, s:format ,s:subs
\ ))

fun! SelectChar(str)
    let s = a:str
    let l = strchars(s)
    let i = 0
    let ll = []
    while i < l
        call add(ll, i+1)
        call add(ll, strcharpart(s, i, 1))
        let i += 1
    endw
    let n = input(join(ll))
    if empty(n) | return '' | endif
    let n -= 1
    return strcharpart(s, n, 1)
endf

call popup#reg('edit#i', pmenu#new('Edit',
    \ [',!', 'Decrease indent', "\<c-d>"],
    \ ['.!', 'Increase indent', "\<c-t>"],
    \ ['l!', 'Dump line', "\<esc>yypA"],
    \ ['d!', 'Delete line', "\<c-o>dd"],
    \ ['i', 'Insert char', [
        \ ['a', 'Arrow', "\<c-r>=SelectChar('↑↓←→↖↗↘↙↔↕')\<cr>"],
        \ ['e', 'Emoji', "\<c-r>=SelectChar('🔺🔻💠🔲')\<cr>"]
        \ ]]
\ ))
