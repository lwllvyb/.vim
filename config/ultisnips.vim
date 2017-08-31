
let g:UltiSnipsExpandTrigger='<c-/>'
let g:UltiSnipsJumpForwardTrigger='<c-/>'
let g:UltiSnipsJumpBackwardTrigger='<c-/>'
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

fun! MyUltiSnipJumpForward()
    if pumvisible() | return "\<c-n>" | endif
    call UltiSnips#JumpForwards()
    if !g:ulti_jump_forwards_res
        call s:RestoreMap()
        return "\<tab>"
    endif
    vnoremap <buffer><tab> <esc>a<c-r>=MyUltiSnipJumpForward()<cr>
    return ''
endf

fun! MyUltiSnipJumpBackward()
    if pumvisible() | return "\<c-p>" | endif
    call UltiSnips#JumpBackwards()
    if !g:ulti_jump_backwards_res
        call s:RestoreMap()
        return "\<s-tab>"
    endif
    vnoremap <buffer><s-tab> <esc>a<c-r>=MyUltiSnipJumpBackward()<cr>
    return ''
endf

let s:maps = []

fun! s:DoMaps()
    call add(s:maps, maparg('<tab>', 'i', 0, 1))
    call add(s:maps, maparg('<s-tab>', 'i', 0, 1))
    call add(s:maps, maparg('<tab>', 's', 0, 1))
    call add(s:maps, maparg('<s-tab>', 's', 0, 1))
    inoremap <buffer><tab> <c-r>=MyUltiSnipJumpForward()<cr>
    inoremap <buffer><s-tab> <c-r>=MyUltiSnipJumpBackward()<cr>
    vnoremap <buffer><tab> <esc>a<c-r>=MyUltiSnipJumpForward()<cr>
    vnoremap <buffer><s-tab> <esc>a<c-r>=MyUltiSnipJumpBackward()<cr>
    " augroup MyUltiSnip
    "     au InsertLeave * call <SID>RestoreMap()
    " augroup end
endf

fun! s:RestoreMap()
    try
        iunmap <buffer><tab>
        iunmap <buffer><s-tab>
        vunmap <buffer><tab>
        vunmap <buffer><s-tab>
    catch | endt
    for opt in s:maps
        call s:map(opt) | endfo
    let s:maps = []
    " augroup! MyUltiSnip
endf

fun! s:map(opt)
    if empty(a:opt) | return | endif
    let mc = has_key(a:opt, 'noremap') ? 'noremap': 'map'
    let md = a:opt.mode
    let mc = md == '!' ? mc . '!' : md . mc
    let lhs = (has_key(a:opt, 'buffer') ? '<buffer>': '') .
            \ (has_key(a:opt, 'expr') ? '<expr>': '') .
            \ (has_key(a:opt, 'silent') ? '<silent>': '') .
            \ (has_key(a:opt, 'nowait') ? '<nowait>': '') . a:opt.lhs
    let rhs = a:opt.rhs
    exe join([mc, lhs, rhs])
endf

fun! s:CompSnips()
    let g:ulti_expand_res = 0
    if pumvisible()
        call UltiSnips#ExpandSnippet()
    else
        let cot = &cot
        set cot&
        call UltiSnips#SnippetsInCurrentScope(1)
        " Get the all snippet's infomation
        let f = strpart(getline('.'), 0, col('.') - 1)
        let lastword = matchstr(f, '\k*$')
        let list = []
        for [key, info] in items(g:current_ulti_dict_info)
            if stridx(key, lastword) == 0
                call add(list, {'word': key, 'menu': info.description})
            endif
        endfo
        " Complete it
        call complete(col('.')-len(lastword), list)
        if len(list) == 1
            call UltiSnips#ExpandSnippet()
        endif
        let &cot = cot
    endif
    if g:ulti_expand_res
        call s:DoMaps()
    endif
    return ''
endf

imap <c-\> <c-r>=<sid>CompSnips()<cr>
