
call popup#reg('debug#n', pmenu#new('Debug',
    \ ['d:', 'Cdb', 'Cdb'],
    \ ['e:', 'CdbEval', 'CdbEval'],
\ ))

call popup#reg('debug#v', pmenu#new('Debug',
    \ ['e', 'CdbEval', "y:CdbEval \<c-r>\"\<cr>"]
\ ))
