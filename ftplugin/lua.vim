if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

set cms=--\ %s
nnoremap <buffer> <silent> <F5> :w<cr>:!lua %:p<cr>
vnoremap <buffer><m-o> yoprint()<esc>P

call dict#addl('lua')
