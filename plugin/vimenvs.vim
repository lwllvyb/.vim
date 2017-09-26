
" Check direcory
if !exists('g:vimenvs#dir')
    let g:vimenvs#dir = expand('~/.cache/vimenvs')
    if !isdirectory(g:vimenvs#dir)
        call mkdir(g:vimenvs#dir, 'p')
    endif
endif

let msvc = g:vimenvs#dir . '/msvc.json'
if filereadable(msvc)
    let cont = readfile(msvc)
    let envs = json_decode(cont[0])
    let $PATH = envs.PATH
    let $LIB = envs.LIB
    let $INCLUDE = envs.INCLUDE
    call vimenvs#setpath(split($INCLUDE, ';'))
    let g:neoinclude#paths = {'c': &path, 'cpp': &path}
endif

