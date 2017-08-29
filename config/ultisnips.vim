
let g:UltiSnipsExpandTrigger='<c-/>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

fun! s:CompSnips()
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
    return ''
endf

imap <c-\> <c-r>=<sid>CompSnips()<cr>
