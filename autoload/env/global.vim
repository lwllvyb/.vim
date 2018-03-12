
fun! env#global#init()
    let data = env#get('global')
    call extend(g:, data['variable'])
    for [k, v] in items(data.option)
        sil! exe 'let &' . k '= v'
    endfo
endf

fun! env#global#gen()
    let global = {'option': {}, 'variable': {}}
    " Find python3
    if has('win32')
        let py3path = exepath('python3')
        if empty(py3path)
            let py3path = input('Input full path of python3: ', '', 'file')
            if !executable(py3path)
                echoe 'There is no python3 available'
            endif
        endif
        let global.variable.python3_host_prog = py3path
        echo 'Python3:' py3path
        let py3dll = glob(fnamemodify(py3path, ':h') . '/python3?.dll')
        if len(py3dll)
            echo 'Python3 DLL:' py3dll
            let global.option.pythonthreedll = py3dll
        endif
    else
        let py3path = exepath('python3')
        if empty(py3path)
            echoe 'There is no python3 available'
        else
            echo 'Python3:' py3path
            let global.variable.python3_host_prog = py3path
        endif
    endif
    return global
endf
