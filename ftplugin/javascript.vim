if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

nmap <buffer><F5> :w<cr>:!node %<cr>

call util#AddBufferDict('nodejs')
