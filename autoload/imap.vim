" =============================================================================
" Filename:    autoload\imap.vim
" Author:      luzhlon
" Date:        2017-09-01
" Description: return different RHS according a list of conditions by imap#
" =============================================================================
fun! imap#(k, opt)
    " 获取当前buffer的imap表，
    "   表里的数字键用来记录第i个键，
    "   '_nr'用来记录下一个要映射的键的序号，
    "   其他键用来映射相应的按键的条件列表
    let m = getbufvar('%', '_imap', {})
    if empty(m)         " call the function firstly
        let b:_imap = m
        let m._nr = 0
    endif
    " 获取条件列表
    let k = a:k | if k=~ '^<'
        let k = eval('"\' . k . '"') | endif
    let conds = get(m, k, [])
    if empty(conds)     " add the k firstly
        let m[k] = conds | let m[m._nr] = k
        " do mapping
        exe printf('imap <expr><buffer> %s imap#_rhs(%d)',
                    \ a:k, m._nr)
        let m._nr += 1
    endif
    " 添加到条件列表
    let M1 = get(a:opt, 'match', '')
    let M2 = get(a:opt, 'match_after', '')
    let RHS = get(a:opt, 'rhs')
    call assert_true(RHS, 'You must specify the "rhs" field')
    call add(conds, type(M1) == v:t_string ?
            \ funcref('imap#match', [M1, M2]) : M1)
    call add(conds, RHS)
endf
" a:b is text before cursor, a:a is after
fun! imap#match(b, a)
    let c = col('.')
    let n = c - 1
    let l = getline('.')
    let f = strpart(l, 0, n)    " first text
    let s = strpart(l, n)       " second text
    return f =~ a:b && s =~ a:a
endf
" get the rhs of the b:_imap[b:_imap[n]] by conditions
fun! imap#_rhs(n)
    let k = b:_imap[a:n]
    let conds = b:_imap[k]
    let i = 0
    while i < len(conds)
        let [Cond, RHS] = conds[i: i+1]
        if Cond()
            if type(RHS) == v:t_func
                return RHS()
            else
                return RHS | endif
        endif
        let i += 2
    endw
    return k
endf
