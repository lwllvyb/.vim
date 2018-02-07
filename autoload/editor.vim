
fun! editor#close_file()
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

fun! editor#reopen_file()
    let file = expand('%:p')
    confirm bw
    exe 'edit' file
endf
