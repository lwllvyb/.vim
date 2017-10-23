
let comment = ['/', 'Comment' , ":Commentary\<cr>"]
let format = ['=', 'Autoformat', ":Autoformat\<cr>"]

let my_subs = [
        \ ['m', 'Comment', ':s/\/\/\s*\(.*\)/\/* \1 *\/' . "\<cr>"],
        \ ['c', 'Width Char', [
            \ ['c', 'Colon', ":s:/：/:/g\<cr>"],
            \ ['b', 'Breakets', ':s:/（\(.\{-}\)）/(\1)/g' . "\<cr>"]]],
        \ ['x', 'Count', ":s/\<c-r>//\\=repeat('-', len(submatch(0)))"],
        \ ['s', 'Spaces', [
            \ ["\t", 'Tab -> Space', ":s/\t/\\=repeat(' ',\&ts)/g\<cr>"] ,
            \ ["\r", 'Del Empty Line', ":g/^$/del\<cr>"],
            \ ['s', 'Del End-Spaces', ':s/\s*\r*$' . "\<cr>"]]],
        \ ['t', 'Html Tag', [
            \ ['s', 'Strip', ':s/<\(\w\+\)[^>]*>\(\_.\{-}\)<\/\1>/\2/g'."\<cr>"],
            \ ["'", "&nbsp -> '", ":s/&nbsp;/'/g"],
            \ ['b', '<br>', ':s/<br\/\?>/\r/g'."\<cr>"]]],
        \ ['/', 'Last search', ":s///g\<left>\<left>"],
        \ ['\', '// && \\', [
            \ ['x', '\ -> \\', ':s/\\/\\\\/g'."\<cr>"],
            \ ['c', '\\ -> \', ':s/\\\\/\\/g'."\<cr>"],
            \ ['/', '/ -> \' , ':s/\//\\/g'."\<cr>"],
            \ ['\', '\ -> /' , ':s/\\/\//g'."\<cr>"]]],
        \ [';', 'Add ;' , ':g! /\(\(\/\/.\{-}\)\|[{};]\|\(else\)\)$/norm A;'."\<cr>"]]

let my_subs = ['s', 'Substitute', my_subs]

call popup#add('edit', 'Edit',
    \ ['l', 'Line-format', [
         \ ['d', 'DOS', ":set ff=dos\<cr>"],
         \ ['u', 'UNIX', ":set ff=unix\<cr>"],
         \ ['m', 'MAC', ":set ff=mac\<cr>"]]],
    \ ['h', 'HEX EDIT', [
        \ ['b', 'Start' , ":set bin|%!xxd\<cr>"],
        \ ['e', 'End' , ":%!xxd -r\<cr>"]]],
    \ ['p', 'Paste', "\"+p"],
    \ ['a', 'Select all', "ggVG"],
    \ my_subs, comment, format)

call popup#add('edit-v', 'Edit',
    \ ['c', 'Copy', "\"+y"],
    \ ['t', 'Cut', "\"+d"],
    \ ['p', 'Paste', "\"+p"],
    \ ['i', 'Insert chars', ':norm I'],
    \ ['a', 'Append chars', ':norm A'],
    \ ['R', 'Reverse lines', ":g/^/move \<c-r>=line(\"'<\")-1\<cr> | noh"],
    \ my_subs, comment, format)

call popup#add('edit-i', 'Edit',
    \ ['l', 'Dump Line', "\<esc>yypA"],
    \ ['p', 'Paste', {->"\<c-o>".(col('.')==col('$')?'"+gp': '"+gP')}])

nmap <expr><m-e> Popup('edit')
vmap <expr><m-e> Popup('edit-v')
imap <expr><m-e> Popup('edit-i')
