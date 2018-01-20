
fun! km#normal(ks, ...)
    let result = col('.') == col('$') ? "\<end>" : ''
    exe a:0 ? 'norm!': 'norm' a:ks
    return result
endf

fun! km#redraw()
    let l = winline()
    let cmd = l * 2 <= winheight(0) + 1 ? l <= (&so + 1) ? 'zb' : 'zt' : 'zz'
    return mode() == 'i' ? km#normal(cmd, '!'): cmd
endf

fun! km#del2end()
    let c = col('.')
    if c == col('$') | return "\<del>" | endif
    exe 'norm! D'
    call cursor(line('.'), c)
    return ''
endf

fun! km#undo()
    undo | return ''
endf

fun! km#redo()
    redo | return ''
endf

fun! km#move2first()
    if mode() == 'i'
        exe 'norm!' col('.') > 1 ? '0' : '^'
        return ''
    else
        return col('.') == 1 ? '^': '0'
    endif
endf

fun! km#on_enter()
    if !pumvisible() || empty(v:completed_item)
        return "\<cr>"
    elseif v:completed_item.menu =~ '^\[ns\]'
        return "\<Plug>(neosnippet_expand_or_jump)"
    elseif v:completed_item.menu =~ '^\[US\]'
        return "\<c-r>=UltiSnips#ExpandSnippet()\<cr>"
    else
        return "\<cr>"
        return deoplete#close_popup()
    endif
endf

fun! km#paste(text)
    set paste
    call timer_start(1, {->execute('set paste!')})
    return a:text
endf

fun! km#enter()
    let ret = "\<cr>"
    if mode() == 'n' || mode() =~? 'v'
        let c = getline('.')[col('.')-1]
        if c =~ '\v[(){}\[\]<>]'
            let ret = '%'
        endif
    endif
    return ret
endf

fun! km#cmd_del2wordend()
    let begin = getcmdpos()
    call timer_start(1, {->feedkeys(repeat("\<bs>", getcmdpos() - begin), 'n')})
    return "\<c-right>"
endf

fun! km#cmd_forward_word()
    let cmd = getcmdline()
    let pos = getcmdpos() - 1
    while cmd[pos] !~ '\w\|[^\x00-\xff]' && pos < len(cmd)
        let pos += 1
    endw
    while cmd[pos] =~ '\w\|[^\x00-\xff]' && pos < len(cmd)
        let pos += 1
    endw
    call setcmdpos(pos + 1)
    return ''
endf

fun! km#cmd_backward_word()
    let cmd = getcmdline()
    let pos = getcmdpos() - 2
    while cmd[pos] !~ '\w\|[^\x00-\xff]' && pos >= 0
        let pos -= 1
    endw
    while cmd[pos] =~ '\w\|[^\x00-\xff]' && pos >= 0
        let pos -= 1
    endw
    call setcmdpos(pos + 2)
    return ''
endf
