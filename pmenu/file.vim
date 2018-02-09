
call popup#reg('file', pmenu#new('File',
    \ ['n:', 'New file', "conf ene"],
    \ ['o:', 'Open file', "browse confirm e"],
    \ ['r:', 'Open recent', "Denite file_mru"],
    \ ['f:', 'Configuration', "Denite menu:myfiles"],
    \ ['h:', 'Scratch', "ene!|setl bt=nofile bh=wipe"],
    \ ["\t", 'Temp files', ':conf e $TEMP/'],
    \ '-----------------------------------------',
    \ ['s:', 'Save', "write"],
    \ ['S:', 'Sudo', "w !sudo tee %"],
    \ ['d', 'Close', "\<c-u>"],
    \ ['a:', 'Save all', "wa"],
    \ ['x:', 'Exit', "confirm qa"]
\ ))
