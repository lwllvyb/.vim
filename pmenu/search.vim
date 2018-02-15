
fun! s:search_in(dir)
    let right = '/ ' . a:dir
    let left = (mode() =~? 'v' ? 'y:': '') . ':vimgrep /'
    let keys = left . right . repeat("\<left>", len(right))
    return mode() =~? 'v' ? keys . "\<c-r>\"" : keys
endf

let s:file_folder = ['f!', 'In file folder', funcref('s:search_in', ['%:p/*'])]
let s:work_folder = ['d!', 'In work folder', funcref('s:search_in', ['*'])]

call popup#reg('search#n', pmenu#new('Search',
    \ ['m', 'EasyMotion 2', "\<Plug>(easymotion-s2)"],
    \ ['l:', 'Denite line', 'Denite -split=horizontal -winheight=5 line'],
    \ s:file_folder, s:work_folder
\ ))

call popup#reg('search#v', pmenu#new('Search',
    \ ['s', 'The text' , "\<c-s>"],
    \ ['w', 'The word' , "\<c-w>"],
    \ s:file_folder, s:work_folder
\ ))

" \ ['e!', 'Replace text' , 'y:%s/\V'."\<c-r>".'"/'],
" \ ['o!', 'Replace word' , 'y:%s/\V\<'."\<c-r>".'"\>/'],
