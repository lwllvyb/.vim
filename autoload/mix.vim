
" Next buffer with &bt=='', cmd = bn!|bp!
fun! mix#SwitchFile(cmd)
    let nr = bufnr('%')
    exe a:cmd
    while bufnr('%') != nr && &buftype != ''
        exe a:cmd
    endw
endf
