
call popup#reg('search#n', pmenu#new('Search',
    \ ['s', 'EasyMotion-S2 <c-\>', "\<Plug>(easymotion-s2)"],
    \ ['l:', 'Denite search line', 'Denite -split=horizontal -winheight=5 line'],
    \ ['d', 'Current Directory',
        \ {->printf(':vim /%s/ %%:h/*', input('pattern: '))}],
\ ))

call popup#reg('search#v', pmenu#new('Search',
    \ ['d', 'Current directory', ":vim /\<c-r>" . '"/ %:h/*'],
    \ ['.', 'The text' , 'y/\V'."\<c-r>\""],
    \ ['w', 'The word' , 'y/\V\<'."\<c-r>".'"\>'],
    \ ['e', 'Replace text' , 'y:%s/\V'."\<c-r>".'"/'],
    \ ['o', 'Replace word' , 'y:%s/\V\<'."\<c-r>".'"\>/'],
\ ))
