
fun! km#redraw()
    let l = winline()
    let cmd = l * 2 <= winheight(0) + 1 ? l <= (&so + 1) ? 'zb' : 'zt' : 'zz'
    if mode() == 'i'
        exe 'norm!' cmd
        return ''
    else
        return cmd
    endif
endf

fun! km#del2end()
    let c = col('.')
    if c == col('$') | return "\<del>" | endif
    let cmd = "\<c-r>=execute('norm! D')\<cr>"
    return c == 1 ? cmd : cmd . "\<right>"
endf

fun! km#undo()
    undo | return ''
endf

fun! km#redo()
    redo | return ''
endf

fun! km#move2first()
    if mode() == 'i'
        exe 'norm! ' col('.') > 1 ? '0' : '^'
        return ''
    else
        return col('.') == 1 ? '^': '0'
    endif
endf

fun! km#moveline2up()
    norm ddkP
    startinsert!
    return ''
endf

fun! km#moveline2down()
    norm ddp
    startinsert!
    return ''
endf

fun! km#on_enter()
    if !pumvisible() || empty(v:completed_item)
        return "\<cr>"
    elseif v:completed_item.menu =~ '^\[US\]'
        return "\<c-r>=UltiSnips#ExpandSnippet()\<cr>"
    else
        return "\<cr>"
        return deoplete#close_popup()
    endif
endf

fun! km#paste()
    exe 'norm!' col('.') ==1 ? 'gP' : 'gp'
    return ''
endf
