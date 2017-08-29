if !exists('g:tab#map')
    let g:tab#map = {
        \ 'tab': ['', "\<tab>"],
        \ 'stab': ['', "\<s-tab>"],
        \ 'cr': ['', "\<cr>"],
        \ 'scr': ['', "\<s-cr>"]}
endif
" list | ft, list
fun! tab#add(...)
    if !a:0 | return | endif
    let ft = type(a:1) == 1 ? a:1 : '*'
    let l = type(a:1) == 3 ? a:1 : a:2
    let g:tab#map[a:ft] = extend(get(g:tab#map, ft, []), l)
endf

fun! s:map(key)
    if exists('b:tab_map')
        return get(b:tab_map, a:key, [])
    endif
    return []
endf
" Get list by name
fun! tab#key(n)
    if !has_key(g:tab#map, a:n)|return|endif
    let l = s:map(a:n) + get(g:tab#map, a:n)
    let [f,b] = lib#curstr(1)
    let i = 0
    let n = len(l)
    while i < n
        let T = l[i]
        if (type(T)== v:t_string && f=~T) ||
         \ (type(T)== v:t_list && f=~T[0] && b=~T[1])
            echom l[i+1]
            return l[i+1]
        endif
        let i += 2
    endw
    echom 'noitem'
    return ''
endf
