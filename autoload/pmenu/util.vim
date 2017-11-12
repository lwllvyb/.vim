
let s:baidu = ":call web#search#by_baidu(@\")\<cr>"
let s:youdao = ":call web#search#by_youdao(@\")\<cr>"
let s:sougou = ":call web#search#by_sougou(@\")\<cr>"

let s:normal = pmenu#new('Util',
    \ [' ', 'No hilight', ":noh\<cr>"],
    \ ['.', 'Do last command', '@:'],
    \ ["/", 'Web search', [
        \ ['b', 'By Baidu', 'yiw' . s:baidu],
        \ ['o', 'By YouDao', 'yiw' . s:youdao],
        \ ['s', 'By Sougou', 'yiw' . s:sougou],
        \ ]],
    \ ["\t", 'NERDTreeToggle', ":NERDTreeToggle\<cr>"],
    \ ["\r", 'NERDFind', ":NERDTreeFind\<cr>"],
    \ )

let s:visual = pmenu#new('Util',
    \ ['x', 'Execute VimL' , "y:exe @\"\<cr>"],
    \ ["/", 'Web search', [
        \ ['b', 'By Baidu', 'y' . s:baidu],
        \ ['o', 'By YouDao', 'y' . s:youdao],
        \ ['s', 'By Sougou', 'y' . s:sougou],
        \ ]],
    \ )

fun! pmenu#util#n()
    return s:normal
endf

fun! pmenu#util#v()
    return s:visual
endf

fun! pmenu#util#V()
    return s:visual
endf
