
augroup pefile
    au BufReadCmd *.exe,*.dll,*.sys call pefile#load()
augroup END
