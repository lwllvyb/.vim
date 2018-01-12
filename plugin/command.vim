" =============================================================================
" Filename:    plugin/mycommand.vim
" Author:      luzhlon
" Date:        2017-08-27
" Description: some useful commands
" =============================================================================

" Echo a dict or list with human readable
com! -nargs=+ -complete=expression Echo call echo#(<args>, 1)
com! EchoRuntimePath call echo#(split(&rtp, ','))
com! EchoPATH call echo#(split($PATH, has('win32')?';': ':'))

" Show syntax attribute
com! SynAttr echo synIDattr(synID(line('.'), col('.'), 1), 'name')

com! HexCalc call hexcalc#init()

fun! s:checktime()
    let wid = win_getid()
    windo checktime
    call win_gotoid(wid)
endf

au FocusGained * call <sid>checktime()
