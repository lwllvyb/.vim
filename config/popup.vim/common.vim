scripte utf-8

fun! CloseBufferOrTerminal()
    try
        if &bt=='nofile' && 2 == confirm('Not a file, continue quit?', "&Yes\ n&No", 2, "Warning")
            return ''
        endif
        if &bt == 'terminal' && has('nvim')
            set bh=wipe
            call jobclose(b:terminal_job_id)
        endif
        let curbuf = bufnr('%')
        let a = bufnr('#')
        exe bufexists(a) && getbufvar(a, '&bt') == '' ? 'b!#': 'bnext'
        exe 'confirm' 'bw' curbuf
    catch
        echo v:errmsg
    finally
        return ''
    endt
endf

call popup#add('file', 'File',
    \ ['n', 'New', ":conf ene\<cr>"],
    \ ['o', 'Open ...', ":browse confirm e\<cr>"],
    \ ['r', 'Recent', ":Denite file_old\<cr>"],
    \ ['f', 'Common', ":Denite menu:myfiles\<cr>"],
    \ ['e', 'Temp', ":conf e \<c-r>=$TEMP\<cr>/"],
    \ ['p', 'Sudo', ":w !sudo tee %\<cr>"],
    \ '-----------------------------------------',
    \ ['s', 'Save', ":w\<cr>"],
    \ ['d', 'Close', ":call CloseBufferOrTerminal()\<cr>"],
    \ ['a', 'Save all', ":wa\<cr>"],
    \ ['x', 'Exit', ":confirm qa\<cr>"])

call popup#add('goto', 'Jump',
    \ ['f', 'Function', ""],
    \ ['d', 'Implentation', "gd"],
    \ ['p', 'Previous', "[["],
    \ ['n', 'Next Function', "]]"])

nmap <expr><m-f> Popup('file')
nmap <expr><m-g> Popup('goto')
map  <expr><m-.> popup#last()
map! <expr><m-.> popup#last()

let g:popup#upkey = "\<c-h>"
