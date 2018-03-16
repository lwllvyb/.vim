
call popup#reg('util#n', pmenu#new('Util',
    \ [' ', 'Common', [
        \ ["\t:", 'NERDTreeToggle', 'NERDTreeToggle'],
        \ ["\r:", 'NERDTreeFind', 'NERDTreeFind'],
        \ [' !', 'No hilight', ":noh\<cr>"],
        \ ['.!', 'Do last command', '@:'],
        \ ['l', 'Open URL', 'gx'],
    \ ]],
    \ ["\t:", 'Tools', [
        \ ['c', 'cmd.exe', "call open#cmd()"],
        \ ['p', 'powershell', "call open#powershell()"],
        \ ['b', 'bash', "call open#bash()"],
        \ ['d', 'File directory', "call open#curdir()"],
        \ ['r', 'reopen vim', "call open#reopen()"],
        \ ['f', 'reopen file', "call open#reopen_curfile()"],
        \ ['a', 'reopen with admin', "call open#with_admin(argv())"],
        \ ['.', 'File under cursor', "call open#cur_file()"],
        \ [',', 'Bash', has('nvim') ? 'winc s | term bash': 'terminal bash'],
    \ ]],
\ ))

let s:baidu = ":call web#search#by_baidu(@\")\<cr>"
let s:youdao = ":call web#search#by_youdao(@\")\<cr>"
let s:sougou = ":call web#search#by_sougou(@\")\<cr>"

call popup#reg('util#v', pmenu#new('Util',
    \ ['x', 'Execute VimL' , "y:exe @\"\<cr>"],
    \ ["/", 'Web search', [
        \ ['b', 'By Baidu', 'y' . s:baidu],
        \ ['o', 'By YouDao', 'y' . s:youdao],
        \ ['s', 'By Sougou', 'y' . s:sougou],
        \ ]],
\ ))
