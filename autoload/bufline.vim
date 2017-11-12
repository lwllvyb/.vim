" =============================================================================
" Filename:     autoload/bufline.vim
" Author:       luzhlon
" Function:     Provides a simple buffer-line utility
" Last Change:  2017/3/25
" =============================================================================
let s:files = []    " files bufnrs

com! -count -nargs=* Bufline call bufline#(v:count ? v:count: input('# '), <args>)

fun! bufline#hilight()
    hi! link MyTabLineSel Normal
    hi! link MyTabLine TabLineFill
    let normal = hlID('Normal')
    let gui_bg = synIDattr(normal, 'bg', 'gui')
    let cui_bg = synIDattr(normal, 'bg', 'cterm')
    let gui_fg = synIDattr(normal, 'fg', 'gui')
    let cui_fg = synIDattr(normal, 'fg', 'cterm')
    let dir_fg_g = synIDattr(hlID('Directory'), 'fg', 'gui')
    let dir_fg_c = synIDattr(hlID('Directory'), 'fg', 'cterm')
    let fill_bg_g = synIDattr(hlID('TabLineFill'), 'bg', 'gui')
    let fill_bg_c = synIDattr(hlID('TabLineFill'), 'bg', 'cterm')
    let warn_fg_g = synIDattr(hlID('WarningMsg'), 'fg', 'gui')
    let warn_fg_c = synIDattr(hlID('WarningMsg'), 'fg', 'cterm')
    call s:hi('TabLineFill',
        \ synIDattr(normal, 'fg', 'gui'), 0,
        \ synIDattr(normal, 'fg', 'cterm'), 0)
    call s:hi('MyTabLineNr', dir_fg_g, fill_bg_g, dir_fg_c, fill_bg_c)
    call s:hi('MyTabLineCurNr', dir_fg_g, gui_bg, dir_fg_c, cui_bg)
    call s:hi('MyTabFillWarn', warn_fg_g, fill_bg_g, warn_fg_c, fill_bg_c)
endf

fun! s:hi(group, gfg, gbg, cfg, cbg)
    exe 'hi' a:group
        \ empty(a:gfg) ? '': 'guifg='.a:gfg
        \ empty(a:gbg) ? '': 'guibg='.a:gbg
        \ empty(a:cfg) ? '': 'ctermfg='.a:cfg
        \ empty(a:cbg) ? '': 'ctermbg='.a:cbg
endf

call bufline#hilight()
au ColorScheme * call bufline#hilight()

" Get buffer list of tabpages
fun! s:tabsbufnr()
    let list = []
    for i in range(1, tabpagenr('$'))
        let fl = tabpagebuflist(i)
        let j = tabpagewinnr(i)-1
        let nr = fl[j]
        let e = j
        while !empty(getbufvar(nr, '&bt'))
            let j = (j+1) % len(fl)
            if j == e | break | endif
            let nr = fl[j]
        endw
        call add(list, nr)
    endfo
    return list
endf

if !exists('g:bufline#buftype')
    let g:bufline#buftype = ['', 'nowrite', 'terminal']
endif

" Get all buffers of common files
fun! s:filesbufnr()
    return map(
            \ filter(getbufinfo({'buflisted':1}),
                    \ {i,v->index(g:bufline#buftype,
                                \ getbufvar(v['bufnr'], '&bt')) >= 0}),
            \ {i,v->v['bufnr']})
    " return map(tabpagebuflist(), {i,v->empty(getbufvar(v, '&bt'))})
endf

" Select a buffer {{{
fun! bufline#(n, ...)
    let n = a:n - 1
    if n < len(s:files) && n >= 0
        " split window
        if index(a:000, 'split') >= 0
            let split = 'winc s'
            let direction = 'aboveleft'
            if index(a:000, 'right') >= 0
                let split = 'winc v'
                let direction = 'belowright'
            endif
            if index(a:000, 'left') >= 0
                let split = 'winc v'
                let direction = 'aboveleft'
            endif
            if index(a:000, 'below') >= 0
                let direction = 'belowright'
            endif
            if index(a:000, 'above') >= 0
                let direction = 'aboveleft'
            endif
            exe direction split
        endif
        " switch buffer
        exe s:files[n] 'b!'
    endif
endf
" }}}

fun! bufline#next()
    let i = index(s:files, bufnr('%'))
    if i >= 0
        let n = s:files[(i + 1) % len(s:files)]
        exe n 'b!'
    endif
endf

fun! bufline#prev()
    let i = index(s:files, bufnr('%'))
    if i >= 0
        exe s:files[i - 1] 'b!'
    endif
endf

" set tabline=%!bufline#bufs() {{{
fun! bufline#bufs()
    let s:files = s:filesbufnr()
    return s:get(s:files)
endf
" }}}

" set tabline=%!bufline#tabs() {{{
fun! bufline#tabs()
    return s:get(s:tabsbufnr())
endf
" }}}

fun! s:get(nrs)
    let curnr = bufnr('%')
    let i = 1 | let l = []
    for nr in a:nrs
        let file = simplify(bufname(nr))
        let file = fnamemodify(file, ':.:gs?\(.\).\{-}[\\\/]?\1\/?')
        let l += ['%', i, 'T',
                \ nr == curnr ? '%#MyTabLineCurNr#': '%#MyTabLineNr#', ' ',
                \ i, ' ',
                \ nr == curnr ? '%#MyTabLineSel#': '%#MyTabLine#',
                \ empty(file) ? '   ': file,
                \ getbufvar(nr, '&mod') ? (nr == curnr ? '%#WarningMsg# • ': '%#MyTabFillWarn# • '): ' ']
        let i += 1
    endfor
    " Special buffer
    if &bt == 'nofile'
        let n = ['%#MyTabLineSel#', get({
                \ 'nerdtree': ' [NerdTree] ',
                \ 'tagbar': ' [Tabbar] ',
                \ 'startify': ' [Startify] ',
                \ 'denite': ' [Denite] '
                \ }, &ft, '')]
        let l += n
    elseif &bt == 'help'
        let l += ['%#MyTabLineSel#', ' [HELP:', expand('%:t'), '] ']
    elseif &bt == 'quickfix'
        let l += ['%#MyTabLineSel#', ' [QuickFix] ']
    endif
    " Tabfill
    let l += ['%T', '%#TabLineFill#', '%=', tabpagenr('$') > 1 ? '%999XX' : 'X']
    return join(l, '')
endf
