
if has('nvim')
    let s:term = [',:', 'Terminal', 'winc s | term bash']
else
    let s:term = [',:', 'Terminal', 'terminal bash']
endif

call popup#reg('util#n', pmenu#new('Util',
    \ [' !', 'No hilight', ":noh\<cr>"],
    \ ["\t:", 'NERDTreeToggle', 'NERDTreeToggle'],
    \ [".:", 'NERDTreeFind', 'NERDTreeFind'],
    \ ["\r", 'Do last command', '@:'],
    \ s:term
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
