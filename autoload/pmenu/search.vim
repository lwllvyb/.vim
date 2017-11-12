
let s:normal = pmenu#new('Search',
    \ ['s', 'EasyMotion-S2 <c-\>', "\<Plug>(easymotion-s2)"],
    \ ['l', 'Denite search line', ":Denite -split=horizontal -winheight=5 line\<cr>"],
    \ ['d', 'Current Directory',
        \ {->printf(':vim /%s/ %%:h/*', input('pattern: '))}],
    \ )

let s:visual = pmenu#new('Search',
    \ ['d', 'Current directory', ":vim /\<c-r>" . '"/ %:h/*'],
    \ ['.', 'The text' , 'y/\V'."\<c-r>\""],
    \ ['w', 'The word' , 'y/\V\<'."\<c-r>".'"\>'],
    \ ['e', 'Replace text' , 'y:%s/\V'."\<c-r>".'"/'],
    \ ['o', 'Replace word' , 'y:%s/\V\<'."\<c-r>".'"\>/'],
    \ )

fun! pmenu#search#n()
    return s:normal
endf

fun! pmenu#search#v()
    return s:visual
endf
