
call popup#add('xmake', 'XMAKE',
    \['q', 'QuickFix' , ":bel copen 8\<cr>"],
    \['a', 'Build all', ":XMake\<cr>"],
    \['b', 'Build ...', ":XMake build "],
    \['r', 'Build&Run', ":XMake run "],
    \['g', 'Generate', ":XMake project -k "],
    \['c', 'Clean', ":XMake clean\<cr>"])

nmap <expr><m-x> Popup('xmake')
