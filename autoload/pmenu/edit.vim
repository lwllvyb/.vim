
let s:subs = [
        \ ['m', 'C Comment', ':s/\/\/\s*\(.*\)/\/* \1 *\/' . "\<cr>"],
        \ ['c', 'Width Char', [
            \ ['c', 'Colon', ":s:/：/:/g\<cr>"],
            \ ['b', 'Breakets', ':s:/（\(.\{-}\)）/(\1)/g' . "\<cr>"]]],
        \ ['x', 'Count', ":s/\<c-r>//\\=repeat('-', len(submatch(0)))"],
        \ ['s', 'Spaces', [
            \ ["\t", 'Tab -> Space', ":s/\t/\\=repeat(' ',\&ts)/g\<cr>"],
            \ ["\r", 'Del Empty Line', ":g/^$/del\<cr>"],
            \ ['s', 'Del End-Spaces', ':s/\s*\r*$' . "\<cr>"]]],
        \ ['t', 'Html Tag', [
            \ ['s', 'Strip', ':s/<\(\w\+\)[^>]*>\(\_.\{-}\)<\/\1>/\2/g'."\<cr>"],
            \ ["'", "&nbsp -> '", ":s/&nbsp;/'/g"],
            \ ['b', '<br>', ':s/<br\/\?>/\r/g'."\<cr>"]]],
        \ ['/', '// && \\', [
            \ ['x', '\ -> \\', ':s/\\/\\\\/g'."\<cr>"],
            \ ['c', '\\ -> \', ':s/\\\\/\\/g'."\<cr>"],
            \ ['/', '/ -> \' , ':s/\//\\/g'."\<cr>"],
            \ ['\', '\ -> /' , ':s/\\/\//g'."\<cr>"]]],
        \ [';', 'Add ;' , ':g! /\(\(\/\/.\{-}\)\|[{};]\|\(else\)\)$/norm A;'."\<cr>"]]

let s:align = ['l', 'Align', ':Tabularize /']
let s:comment = [';', 'Comment' , ":Commentary\<cr>"]
let s:format = ['=', 'Autoformat', ":Autoformat\<cr>"]
let s:subs = ['s', 'Substitute', s:subs]

let s:normal = pmenu#new('Edit',
    \ ['f', 'Line-format', [
         \ ['d', 'DOS', ":set ff=dos\<cr>"],
         \ ['u', 'UNIX', ":set ff=unix\<cr>"],
         \ ['m', 'MAC', ":set ff=mac\<cr>"]]],
    \ ['h', 'HEX EDIT', [
        \ ['b', 'Start' , ":set bin|%!xxd\<cr>"],
        \ ['e', 'End' , ":%!xxd -r\<cr>"]]],
    \ ['p', 'Paste', "\"+p"],
    \ ['a', 'Select all', "ggVG"],
    \ ['c', 'Copy filename', ":let @+ = expand('%')"],
    \ ['/', 'Last search', ":s///g\<left>\<left>"],
    \ s:align, s:comment, s:format ,s:subs)

let s:visual = pmenu#new('Edit',
    \ ['e', 'Encode/Decode', [
        \ ['r', 'ROT13', 'g?'],
        \ ['b', 'BASE64 Encode', 'g?'],
        \ ['B', 'BASE64 Decode', 'g?'],
        \ ['m', 'Morse Encode', 'g?'],
        \ ['M', 'Morse Decode', 'g?'],
        \ ['a', 'ASCII Encode', 'g?'],
        \ ['A', 'ASCII Decode', 'g?'],
        \ ]],
    \ ['c', 'Copy', "\"+y"],
    \ ['t', 'Cut', "\"+d"],
    \ ['p', 'Paste', "\"+p"],
    \ ['i', 'Insert chars', ':norm I'],
    \ ['a', 'Append chars', ':norm A'],
    \ ['R', 'Reverse lines', ":g/^/move \<c-r>=line(\"'<\")-1\<cr> | noh"],
    \ s:align, s:comment, s:format ,s:subs)

let s:insert = pmenu#new('Edit',
    \ ['l', 'Dump Line', "\<esc>yypA"],
    \ ['p', 'Paste', {->"\<c-o>".(col('.')==col('$')?'"+gp': '"+gP')}])

fun! pmenu#edit#n()
    return s:normal
endf

fun! pmenu#edit#v()
    return s:visual
endf

fun! pmenu#edit#i()
    return s:insert
endf
