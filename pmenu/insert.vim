
fun! SelectChar(str)
    let s = a:str
    let l = strchars(s)
    let i = 0
    let ll = []
    while i < l
        call add(ll, i+1)
        call add(ll, strcharpart(s, i, 1))
        let i += 1
    endw
    let n = input(join(ll))
    if empty(n) | return '' | endif
    let n -= 1
    return strcharpart(s, n, 1)
endf

call popup#reg('insert#i', pmenu#new('Insert',
    \ ['s', 'Special character', [
        \ ['a', 'Arrow', "\<c-r>=SelectChar('↑↓←→↖↗↘↙↔↕')\<cr>"],
        \ ['e', 'Emoji', "\<c-r>=SelectChar('🔺🔻💠🔲')\<cr>"]
        \ ]]
\ ))
