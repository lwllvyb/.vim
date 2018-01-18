
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
    \ ['h', 'HEX EDIT', [
        \ ['b:', 'Start' , 'set bin|%!xxd'],
        \ ['e:', 'End' , '%!xxd -r']]],
    \ ['a', 'Select all', "ggVG"],
    \ ['c', 'Copy filename', ":let @+ = expand('%')"],
    \ ['/', 'Last search', ":s///g\<left>\<left>"],
    \ s:align, s:comment, s:format ,s:subs
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

call popup#reg('edit#i', pmenu#new('Edit',
    \ ['l', 'Dump Line', "\<esc>yypA"],
    \ ['d', 'Delete Line', "\<c-o>dd"],
\ ))
