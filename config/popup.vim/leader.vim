
call popup#add('leader', 'Leader',
    \ ['s', 'EasyMotion-S2', "\<Plug>(easymotion-s2)"],
    \ ['d', 'Cdb', ":Cdb\<cr>"],
    \ ['e', 'CdbEval', ":CdbEval\<cr>"],
    \ ['f', 'NERDFind', ":NERDTreeFind\<cr>"],
    \ )

call popup#add('leader-v', 'Leader',
    \ ['e', 'CdbEval', "y:CdbEval \<c-r>\"\<cr>"]
    \ )

nmap <expr><leader> Popup('leader')
vmap <expr><leader> Popup('leader-v')
