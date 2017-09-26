
fun! keymap#ctrl_l()
    let l = line('.')
    let wl = winline()
    let wh = winheight(0)
    let b = wh - &so
    let t = &so + 1
    " l in [TOP, MIDDLE]
    return wl * 2 <= wh + 1 ?
        \ wl <= t ? 'zb' : 'zt'
        \ : 'zz'   " l in (MIDDLE, BOTTOM)
endf
