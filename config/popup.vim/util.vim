scripte utf-8
let sub = [['/', '// && \\', [
            \ ['x', '\ -> \\', ':s/\\/\\\\/g'."\<cr>"],
            \ ['c', '\\ -> \', ':s/\\\\/\\/g'."\<cr>"],
            \ ['/', '/ -> \' , ':s/\//\\/g'."\<cr>"],
            \ ['\', '\ -> /' , ':s/\\/\//g'."\<cr>"]]],
        \ ['m', 'Comment', ':s/\/\/\s*\(.*\)/\/* \1 *\/' . "\<cr>"],
        \ ['c', 'Width Char', [
            \ ['c', 'Colon', ":s:/：/:/g\<cr>"],
            \ ['b', 'Breakets', ':s:/（\(.\{-}\)）/(\1)/g' . "\<cr>"]]],
        \ ['x', 'Count', ":s/\<c-r>//\\=repeat('-', len(submatch(0)))"],
        \ ['s', 'Spaces', [
            \ ["\t", 'Tab -> Space', ":s/\t/\\=repeat(' ',\&ts)/g\<cr>"] ,
            \ ["\r", 'Del Empty Line', ":g/^$/del\<cr>"],
            \ ['s', 'Del End-Spaces', ':s/\s*\r*$' . "\<cr>"]]],
        \ [';', 'Add ;' , ':g! /\(\(\/\/.\{-}\)\|[{};]\|\(else\)\)$/norm A;'."\<cr>"]]

let sub = ['s', 'Substitute', sub]

call popup#add('util', 'Util',
    \ [' ', 'No hilight', ":noh\<cr>"],
    \ ['.', 'Ex-command', '@:'], sub,
    \ ['f', 'Cursor File', ":call open#cur_file()\<cr>"],
    \ ['o', 'Open/Reopen', [
        \ ['c', 'cmd.exe', ":call open#cmd()\<cr>"],
        \ ['p', 'powershell', ":call open#powershell()\<cr>"],
        \ ['b', 'bash', ":call open#bash()\<cr>"],
        \ ['d', 'file-directory', ":call open#curdir()\<cr>"],
        \ ['r', 'reopen vim', ":call open#reopen()\<cr>"],
        \ ['f', 'reopen file', ":call open#reopen_curfile()\<cr>"]
    \ ]])
call popup#add('util-v', 'Util',
    \ ['x', 'Execute VimL' , "y:exe @\"\<cr>"], sub)

nnoremap <expr><space>  Popup('util')
vnoremap <expr><space>  Popup('util-v')
