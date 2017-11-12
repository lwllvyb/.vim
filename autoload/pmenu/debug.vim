
let s:normal = pmenu#new('Debug',
    \ ['d', 'Cdb', ":Cdb\<cr>"],
    \ ['e', 'CdbEval', ":CdbEval\<cr>"],
    \ )

let s:visual = pmenu#new('Debug',
    \ ['e', 'CdbEval', "y:CdbEval \<c-r>\"\<cr>"]
    \ )

fun! pmenu#debug#n()
    return s:normal
endf

fun! pmenu#debug#v()
    return s:visual
endf
