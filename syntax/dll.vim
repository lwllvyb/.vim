
if executable('dumpbin')
    set bt=nowrite
    0,$del
    exe 'r' '!dumpbin' '/exports' shellescape(expand('%'))
    syn match ExportFunction /^\s*\d\+\s\+\x\+\s\+\x\+\s\+\zs.*/
    hi link ExportFunction Identifier
    norm! ggMzt
endif
