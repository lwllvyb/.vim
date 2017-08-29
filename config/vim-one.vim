let g:one_allow_italics = 1

fun! s:onstart()
    " call one#highlight('vimLineComment', 'cccccc', '', 'none')
    " hi Cursor guifg=NONE guibg=#526fff
endf

au! VimEnter * call <sid>onstart()
