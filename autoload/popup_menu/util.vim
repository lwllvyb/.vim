scripte utf-8

let baidu = ":call web#search#by_baidu(@\")\<cr>"
let youdao = ":call web#search#by_youdao(@\")\<cr>"
let sougou = ":call web#search#by_sougou(@\")\<cr>"

call popup#add('Util', popup#menu(
    \ popup#item(' ', 'No hilight', ":noh\<cr>"),
    \ popup#item('.', 'Last ex-command', '@:'),
    \ popup#item("/", 'Web search', popup#menu(
        \ popup#item('b', 'By Baidu', 'yiw' . baidu),
        \ popup#item('o', 'By YouDao', 'yiw' . youdao),
        \ popup#item('s', 'By Sougou', 'yiw' . sougou)
        \ )),
    \ popup#item("\t", 'NERDTreeToggle', ":NERDTreeToggle\<cr>"),
    \ popup#item("\r", 'NERDFind', ":NERDTreeFind\<cr>"),
\ ))

call popup#add('util-v', 'Util',
    \ ['x', 'Execute VimL' , "y:exe @\"\<cr>"],
    \ ["/", 'Web search', [
        \ ['b', 'By Baidu', 'y' . baidu],
        \ ['o', 'By YouDao', 'y' . youdao],
        \ ['s', 'By Sougou', 'y' . sougou],
        \ ]],
    \ )
