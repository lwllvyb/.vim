
call popup#add('search', 'Search',
    \ ['s', 'EasyMotion-S2 <c-\>', "\<Plug>(easymotion-s2)"],
    \ ['d', 'Current Directory',
        \ {->printf(':vim /%s/ %%:h/*', input('pattern: '))}],
    \ ['/', 'Replace /', ":%s/\<c-r>///g\<left>\<left>"])

call popup#add('search-v', 'Search',
    \ ['d', 'Current directory', ":vim /\<c-r>" . '"/ %:h/*'],
    \ ['.', 'The text' , 'y/\V'."\<c-r>\""],
    \ ['w', 'The word' , 'y/\V\<'."\<c-r>".'"\>'],
    \ ['e', 'Replace text' , 'y:%s/\V'."\<c-r>".'"/'],
    \ ['o', 'Replace word' , 'y:%s/\V\<'."\<c-r>".'"\>/'],
    \ ['/', 'Replace /', ":s/\<c-r>///g\<left>\<left>"])

nmap <expr><m-s> Popup('search')
vmap <expr><m-s> Popup('search-v')
