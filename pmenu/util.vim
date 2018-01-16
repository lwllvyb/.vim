
let s:baidu = ":call web#search#by_baidu(@\")\<cr>"
let s:youdao = ":call web#search#by_youdao(@\")\<cr>"
let s:sougou = ":call web#search#by_sougou(@\")\<cr>"

call popup#reg('util#n', pmenu#new('Util',
    \ [' !', 'No hilight', ":noh\<cr>"],
    \ ['.:', 'Do last command', 'sil! exe @:'],
    \ ['/', 'Web search', [
        \ ['b', 'By Baidu', 'yiw' . s:baidu],
        \ ['o', 'By YouDao', 'yiw' . s:youdao],
        \ ['s', 'By Sougou', 'yiw' . s:sougou],
        \ ]],
    \ ["\t:", 'NERDTreeToggle', 'NERDTreeToggle'],
    \ ["\r:", 'NERDTreeFind', 'NERDTreeFind'],
\ ))

call popup#reg('util#v', pmenu#new('Util',
    \ ['x', 'Execute VimL' , "y:exe @\"\<cr>"],
    \ ["/", 'Web search', [
        \ ['b', 'By Baidu', 'y' . s:baidu],
        \ ['o', 'By YouDao', 'y' . s:youdao],
        \ ['s', 'By Sougou', 'y' . s:sougou],
        \ ]],
\ ))
