
call popup#add('search', 'Search',
    \ ['s', 'EasyMotion-S2 <c-\>', "\<Plug>(easymotion-s2)"],
    \ ['l', 'Denite search line', ":Denite -split=horizontal -winheight=5 line\<cr>"],
    \ ['d', 'Current Directory',
        \ {->printf(':vim /%s/ %%:h/*', input('pattern: '))}],
    \ )

call popup#add('search-v', 'Search',
    \ ['d', 'Current directory', ":vim /\<c-r>" . '"/ %:h/*'],
    \ ['.', 'The text' , 'y/\V'."\<c-r>\""],
    \ ['w', 'The word' , 'y/\V\<'."\<c-r>".'"\>'],
    \ ['e', 'Replace text' , 'y:%s/\V'."\<c-r>".'"/'],
    \ ['o', 'Replace word' , 'y:%s/\V\<'."\<c-r>".'"\>/'],
    \ )

nmap <expr><m-s> Popup('search')
vmap <expr><m-s> Popup('search-v')
