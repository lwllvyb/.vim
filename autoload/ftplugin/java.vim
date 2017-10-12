
com! -buffer Assign exe 'Tabularize /\w\+\s\+=' \| exe 'Tabularize /='

nmap <buffer><F4> <Plug>(JavaComplete-Imports-AddSmart)
nmap <buffer><F6> <Plug>(JavaComplete-Imports-AddMissing)
nmap <buffer><F7> <Plug>(JavaComplete-Imports-RemoveUnused)
nmap <buffer><F8> <Plug>(JavaComplete-Imports-SortImports)
