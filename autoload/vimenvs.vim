
let s:path = expand('<sfile>:p:h')

fun! vimenvs#setpath(paths)
    let path = a:paths
    if type(path) == v:t_list
        let path = map(a:paths, {i,v->substitute(v, ' ', '\\ ', 'g')})
    endif
    let &path = join(path, ',')
endf

fun! vimenvs#msvc()
    if has('python3')
        " find vcvarsall.bat
        let fpy = s:path . '/find-vcvars.py'
        exe 'py3f' fpy
        let vvpath = py3eval('_')
        " load environtment variables
        let tf = tempname()
        fun! OnExit(job, data, evt) closure
            " store the environtment variables
            let cont = readfile(tf)
            let $INCLUDE = cont[0]
            let $LIB = cont[1]
            let $PATH = cont[2]
            call writefile(
                \[json_encode({'INCLUDE': cont[0], 'LIB': cont[1], 'PATH': cont[2]})],
                \ g:vimenvs#dir . '/msvc.json')
            echo "\rvimenvs: mscv environtment stored"
        endf
        let job = jobstart(['cmd.exe'], {'on_exit': funcref('OnExit')})
        call jobsend(job, join(['@echo off',
            \ printf('call "%s" x64 > nul', vvpath),
            \ printf('echo %%INCLUDE%%>"%s"', tf),
            \ printf('echo %%LIB%%>>"%s"', tf),
            \ printf('echo %%PATH%%>>"%s"', tf),
            \ 'exit', ''], "\r\n"))
        echo 'vimenvs: seaching compiler environtment ...'
    endif
endf
