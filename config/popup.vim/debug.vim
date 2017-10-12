
call popup#add('debug', 'Debug',
    \ ['d', 'Cdb', ":Cdb\<cr>"],
    \ ['e', 'CdbEval', ":CdbEval\<cr>"],
    \ )

call popup#add('debug-v', 'Debug',
    \ ['e', 'CdbEval', "y:CdbEval \<c-r>\"\<cr>"]
    \ )

nmap <expr><leader> Popup('debug')
vmap <expr><leader> Popup('debug-v')
