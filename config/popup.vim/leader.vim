
call popup#add('leader', 'Leader',
    \ ['s', 'EasyMotion-S2', "\<Plug>(easymotion-s2)"],
    \ ['f', 'NERDFind', ":NERDTreeFind\<cr>"],
    \ )

nmap <expr><leader> Popup('leader')
