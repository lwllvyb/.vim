
setl cms=--\ %s
nnoremap <buffer> <silent> <F5> :w<cr>:!lua %:p<cr>
vnoremap <buffer><m-o> yoprint()<esc>P
