
fun! s:foo()
    if getbufvar('#', '&ft') == 'nerdtree' && getbufvar('#', '&bt') == 'nofile'
        silent! buffer #
        echo 'You can not switch to another buffer in a NERDTree window'
    endif
endf

au BufEnter * call <sid>foo()
