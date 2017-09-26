
fun! map#restore(opt)
    if type(a:opt) == v:t_list
        for opt in a:opt
            call map#derestore(opt)
        endfo
    elseif type(a:opt) == v:t_dict
        call map#derestore(a:opt)
    endif
endf

fun map#store(...)
    let l = []
    for k in a:000
        let d = maparg(k, '', 0, 1)
        if empty(d)
            let d.lhs = k
        endif
        call add(l, d)
    endfo
    return l
endf

fun! map#derestore(opt)
    if empty(a:opt) | return | endif
    if has_key(a:opt, 'rhs')
        let mc = has_key(a:opt, 'noremap') ? 'noremap': 'map'
        let md = a:opt.mode
        let mc = md == '!' ? mc . '!' : md . mc
        let lhs = (get(a:opt, 'buffer') ? '<buffer>': '') .
                \ (get(a:opt, 'expr') ? '<expr>': '') .
                \ (get(a:opt, 'silent') ? '<silent>': '') .
                \ (get(a:opt, 'nowait') ? '<nowait>': '') . a:opt.lhs
        let rhs = a:opt.rhs
        exe join([mc, lhs, rhs])
    else
        exe 'unmap' a:opt.lhs
    endif
endf
