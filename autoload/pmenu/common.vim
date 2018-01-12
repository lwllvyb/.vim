
fun! CloseBuffer()
    try
        if &bt=='nofile' && 2 == confirm(
                    \ 'Not a file, continue quit?',
                    \ "&Yes\ n&No", 2, "Warning")
            return
        elseif &bt == 'terminal' && has('nvim')
            set bh=wipe
            call jobclose(b:terminal_job_id)
        endif
        let curbuf = bufnr('%')
        let lastbuf = bufnr('#')
        exe bufexists(lastbuf) && empty(getbufvar(lastbuf, '&bt')) ? 'b!#': 'bnext'
        exe 'confirm' curbuf 'bw'
    catch
        echoe v:errmsg
    endt
endf

let s:file = pmenu#new('File',
    \ ['n', 'New', ":conf ene\<cr>"],
    \ ['o', 'Open ...', ":browse confirm e\<cr>"],
    \ ['r', 'Open recent', ":Denite file_mru\<cr>"],
    \ ['f', 'Open Common', ":Denite menu:myfiles\<cr>"],
    \ ['h', 'Scratch', ":ene!|setl bt=nofile bh=wipe\<cr>"],
    \ ['c', 'Cursor', ":call open#cur_file()\<cr>"],
    \ ['p', 'Sudo', ":w !sudo tee %\<cr>"],
    \ ['e', 'External tools', [
        \ ['c', 'cmd.exe', ":call open#cmd()\<cr>"],
        \ ['p', 'powershell', ":call open#powershell()\<cr>"],
        \ ['b', 'bash', ":call open#bash()\<cr>"],
        \ ['d', 'file-directory', ":call open#curdir()\<cr>"],
        \ ['r', 'reopen vim', ":call open#reopen()\<cr>"],
        \ ['f', 'reopen file', ":call open#reopen_curfile()\<cr>"]
        \ ]],
    \ ['m', 'Temp files', ":conf e \<c-r>=$TEMP\<cr>/"],
    \ '-----------------------------------------',
    \ ['s', 'Save', ":w\<cr>"],
    \ ['d', 'Close', ":call CloseBuffer()\<cr>"],
    \ ['a', 'Save all', ":wa\<cr>"],
    \ ['x', 'Exit', ":confirm qa\<cr>"])

let s:jump = pmenu#new('Jump',
    \ ['f', 'Function', ""],
    \ ['d', 'Implentation', "gd"],
    \ ['p', 'Previous', "[["],
    \ ['n', 'Next Function', "]]"])

fun! pmenu#common#file()
    return s:file
endf

fun! pmenu#common#goto()
    return s:jump
endf

