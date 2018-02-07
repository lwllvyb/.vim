
call popup#reg('common#file', pmenu#new('File',
    \ ['n:', 'New', "conf ene"],
    \ ['o:', 'Open ...', "browse confirm e"],
    \ ['r:', 'Open recent', "Denite file_mru"],
    \ ['f:', 'Open Common', "Denite menu:myfiles"],
    \ ['h:', 'Scratch', "ene!|setl bt=nofile bh=wipe"],
    \ ['c:', 'Cursor', "call open#cur_file()"],
    \ ['p:', 'Sudo', "w !sudo tee %"],
    \ ['e:', 'External tools', [
        \ ['c:', 'cmd.exe', "call open#cmd()"],
        \ ['p:', 'powershell', "call open#powershell()"],
        \ ['b:', 'bash', "call open#bash()"],
        \ ['d:', 'file-directory', "call open#curdir()"],
        \ ['r:', 'reopen vim', "call open#reopen()"],
        \ ['f:', 'reopen file', "call open#reopen_curfile()"]
        \ ]],
    \ ['m', 'Temp files', ':conf e $TEMP/'],
    \ '-----------------------------------------',
    \ ['s:', 'Save', "write"],
    \ ['d:', 'Close', "call editor#close_file()"],
    \ ['a:', 'Save all', "wa"],
    \ ['x:', 'Exit', "confirm qa"]
\ ))

call popup#reg('common#goto', pmenu#new('Jump',
    \ ['f', 'Function', ""],
    \ ['d', 'Implentation', "gd"],
    \ ['p', 'Previous', "[["],
    \ ['n', 'Next Function', "]]"]
\ ))
