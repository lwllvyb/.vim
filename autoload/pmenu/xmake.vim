
let s:normal = pmenu#new('XMAKE',
    \['q', 'QuickFix' , ":bel copen 8\<cr>"],
    \['a', 'Build all', ":XMake\<cr>"],
    \['b', 'Build ...', ":XMake build "],
    \['r', 'Build&Run', ":XMake run "],
    \['g', 'Generate', ":XMake project -k "],
    \['c', 'Clean', ":XMake clean\<cr>"])

fun! pmenu#xmake#n()
    return s:normal
endf
