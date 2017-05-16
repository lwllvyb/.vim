if !exists('g:tabmap')
    let g:tabmap = {'*': []}
endif
" list | ft, list
fun! tab#add(...)
    if !a:0 | return | endif
    let ft = type(a:1) == 1 ? a:1 : '*'
    let l = type(a:1) == 3 ? a:1 : a:2
    let g:tabmap[a:ft] = extend(get(g:tabmap, ft, []), l)
endf
" Get list by name
fun! tab#key(n)
    if !has_key(g:tabmap, a:n)|return|endif
    let m = g:tabmap[a:n]
    let l = get(m, &ft, []) + get(m, '*', [])
    let n = len(l)
    let [f,b] = lib#curstr(1)
    let i = 0
    while i < n
        let t = l[i]
        if (type(t)==1 && f=~t) ||
         \ (type(t)==3 && f=~t[0] && b=~t[1])
            return l[i+1]
        endif
        let i += 2
    endw
    return m['.']
endf
