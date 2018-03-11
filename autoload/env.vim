
let s:envdir = glob('~/.config/envs.vim')
let s:format = s:envdir . '/%s.json'

let s:env_cache = {}

fun! env#get(var)
    if has_key(s:env_cache, a:var)
        return s:env_cache[a:var]
    endif
    let file = printf(s:format, a:var)
    if filereadable(file)
        let data = json_decode(join(readfile(file)))
        let s:env_cache[a:var] = data
        return data
    else
        try
            echo 'Try load the env:' a:var
            let data = env#{a:var}#gen()
            call env#set(a:var, data)
            return env#get(a:var)
        catch /E117/
            echoe 'Load env' a:var 'failure:' v:errmsg
        endtry
    endif
endf

fun! env#set(var, val)
    let file = printf(s:format, a:var)
    return writefile([json_encode(a:val)], file)
endf

fun! env#init(list)
    for env in a:list
        try
            call env#{env}#init()
        catch /E117/
            echom 'Load' env 'failure:' v:errmsg
        endtry
    endfo
endf
