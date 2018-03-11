
fun! km#feedkeys(...)
    call call('feedkeys', a:000) | return ''
endf

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

fun! km#enter_insert()
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

fun! km#_match_cursor()
    if has_key(b:, 'match_words')
        let word = expand('<cword>')
        for pat in split(b:match_words, '[:,]')
            if word =~# pat | return 1 | endif
        endfo
    endif
endf

fun! km#enter_normal()
    let cc = matchstr(getline('.'), '.', col('.')-1, 1)
    let ispair = index(split(&matchpairs, '[:,]'), cc) >= 0
    return ispair || km#_match_cursor() ? '%': "\<cr>"
endf

fun! km#tab_insert()
    if pumvisible()
        return km#feedkeys("\<c-n>", 'n')
    endif
    try
        if neosnippet#expandable_or_jumpable()
            return km#feedkeys("\<Plug>(neosnippet_expand_or_jump)")
        endif
    catch | endt
    return km#feedkeys("\<tab>", 'n')
endf

let s:surround_char = {
    \ '{': '}', '}': '}',
    \ '(': ')', ')': ')',
    \ '[': ']', ']': ']',
    \ '<': '>', '>': '>',
    \ '"': '"', "'": "'",
\ }

fun! km#delete_quote()
    " Please install surround.vim first
    let cc = matchstr(getline('.'), '.', col('.')-1, 1)
    return has_key(s:surround_char, cc) ? 'ds' . s:surround_char[cc]: ''
endf

fun! km#change_quote()
    " Please install surround.vim first
    let cc = matchstr(getline('.'), '.', col('.')-1, 1)
    return has_key(s:surround_char, cc) ? 'cs' . s:surround_char[cc]: ''
endf

fun! km#run()
    if exists('g:xmproj')
        XMake run
    else
        call qrun#()
    endif
endf

" commandline-edit {{{
fun! km#cmd_del2wordend()
    let pos = getcmdpos()
    let text = getcmdline()[pos-1:]
    let blank = matchstr(text, '^\s\+')
    if len(blank)
        return repeat("\<del>", len(blank))
    else
        call timer_start(1, {->feedkeys(repeat("\<bs>", getcmdpos()-pos), 'n')})
        return "\<c-right>"
    endif
endf

fun! km#cmd_forward_word()
    let cmd = getcmdline()
    let pos = getcmdpos() - 1
    " Skip the non-word chars
    while cmd[pos] !~ '\w\|[^\x00-\xff]' && pos < len(cmd)
        let pos += 1
    endw
    " Move to previous word left
    while cmd[pos] =~ '\w\|[^\x00-\xff]' && pos < len(cmd)
        let pos += 1
    endw
    call setcmdpos(pos + 1)
    return ''
endf

fun! km#cmd_backward_word()
    let cmd = getcmdline()
    let pos = getcmdpos() - 2
    " Skip the non-word chars
    while cmd[pos] !~ '\w\|[^\x00-\xff]' && pos >= 0
        let pos -= 1
    endw
    " Move to next word right
    while cmd[pos] =~ '\w\|[^\x00-\xff]' && pos >= 0
        let pos -= 1
    endw
    call setcmdpos(pos + 2)
    return ''
endf
" }}}
