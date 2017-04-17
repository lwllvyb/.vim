" =============================================================================
" Filename:     plugin/mycolor.vim
" Author:       luzhlon
" Function:     color setting on gui
" Last Change:  2017/4/07
" =============================================================================

fun! s:hi(x, fg, bg, ...)
    let [x, fg, bg] = [a:x,
                \ empty(a:fg) ? '' : 'guifg='.a:fg,
                \ empty(a:bg) ? '' : 'guibg='.a:bg]
    exe 'hi' x fg bg join(a:000)
endf
fun! s:clear(...)
    for i in a:000
        exe 'hi' 'clear' i
    endfo
endf

let s:normalfg = '#494b53'
let s:normalbg = '#fafafa'
let s:cursorbg = '#526fff'

fun! s:setColor()
    if g:colors_name!='PaperColor'|return|endif
    call s:clear("TabLine", "TabLineFill", "StatusLine", "Folded", 'Conceal',
                \ "StatusLineNC", "VertSplit", "Visual", "Cursor", 'Keyword')
    call s:hi('Cursor', '', s:cursorbg)
    call s:hi('Normal', s:normalfg, s:normalbg)
    call s:hi('LineNr', '#b2b2b2', s:normalbg)
    call s:hi('TabLineSel', '#ffffff', '#4078f2', 'gui=bold')
    call s:hi('MatchParen', '#e45649', '#f0f0f0', 'gui=bold,underline')
    call s:hi('StatusLine', '#a0a1a7', '', 'gui=reverse')
    call s:hi('StatusLineNC', '#494b53', '#f0f0f0')
    call s:hi('VertSplit', '#e7e9e1', s:normalbg)
    call s:hi('Visual', 0, '#d0d0d0')
    call s:hi('Folded', 0, '#afd7ff')
    call s:hi('Conceal', 0, s:normalbg)
    call s:hi('Keyword', '#f92672', 0)
endf

if has('gui_running')
    au VimEnter,ColorScheme * call <SID>setColor()
endif
