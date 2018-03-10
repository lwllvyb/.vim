
let s:envdir = glob('~/.config/envs.vim')
let s:format = s:envdir . '/%s.json'

fun! env#get(var)
    let file = printf(s:format, a:var)
    if filereadable(file)
        let content = readfile(file)
        return json_decode(join(content))
    else
        throw 'There is no env: ' . a:var
    endif
endf

fun! env#set(var, val)
    let file = printf(s:format, a:var)
    return writefile([json_encode(a:val)], file)
endf
