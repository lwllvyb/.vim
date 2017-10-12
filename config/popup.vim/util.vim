scripte utf-8

let baidu = ":call web#search#by_baidu(@\")\<cr>"
let youdao = ":call web#search#by_youdao(@\")\<cr>"
let sougou = ":call web#search#by_sougou(@\")\<cr>"

call popup#add('util', 'Util',
    \ [' ', 'No hilight', ":noh\<cr>"],
    \ ['.', 'Last ex-command', '@:'],
    \ ["/", 'Web search', [
        \ ['b', 'By Baidu', 'yiw' . baidu],
        \ ['o', 'By YouDao', 'yiw' . youdao],
        \ ['s', 'By Sougou', 'yiw' . sougou],
        \ ]],
    \ ['\', 'Else .. ', [
        \ ['c', 'Copy filename', ":let @+ = expand('%')\<cr>"],
        \ ]],
    \ ["\t", 'NERDTreeToggle', ":NERDTreeToggle\<cr>"],
    \ ["\r", 'NERDFind', ":NERDTreeFind\<cr>"],
    \ )

call popup#add('util-v', 'Util',
    \ ['x', 'Execute VimL' , "y:exe @\"\<cr>"],
    \ ["/", 'Web search', [
        \ ['b', 'By Baidu', 'y' . baidu],
        \ ['o', 'By YouDao', 'y' . youdao],
        \ ['s', 'By Sougou', 'y' . sougou],
        \ ]],
    \ )

nnoremap <expr><silent><space> Popup('util')
vnoremap <expr><silent><space> Popup('util-v')
