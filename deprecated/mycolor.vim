" =============================================================================
" Filename:     plugin/mycolor.vim
" Author:       luzhlon
" Function:     color setting on gui
" Last Change:  2017/4/07
" =============================================================================
finish
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
fun! s:hiTerm(x, fg, bg, ...)
    let [x, fg, bg] = [a:x,
                \ empty(a:fg) ? '' : 'ctermfg='.a:fg,
                \ empty(a:bg) ? '' : 'ctermbg='.a:bg]
    exe 'hi' x fg bg join(a:000)
endf

let s:normalfg = '#494b53'
let s:normalbg = '#CCE8CF'
let s:cursorbg = '#526fff'

fun! s:ColorGui()
    if g:colors_name!='PaperColor'|return|endif
    call s:clear('TabLine', 'TabLineFill', 'StatusLine', 'Folded', 'Conceal',
                \ 'StatusLineNC', 'VertSplit', 'Visual', 'Cursor', 'Keyword')
    call s:hi('TabLine', 0, s:normalbg, 'gui=underline')
    call s:hi('TabLineFill', 0, s:normalbg, 'gui=underline')
    call s:hi('Cursor', 0, s:cursorbg)
    call s:hi('Normal', s:normalfg, s:normalbg)
    call s:hi('LineNr', '#b2b2b2', s:normalbg)
    call s:hi('TabLineSel', 'White', '#4078f2', 'gui=bold,underline')
    call s:hi('MatchParen', '#e45649', '#f0f0f0', 'gui=bold,underline')
    call s:hi('StatusLine', 'White', '#a0a1a7')
    call s:hi('StatusLineNC', s:normalfg, '#f0f0f0')
    call s:hi('VertSplit', '#e7e9e1', s:normalbg)
    call s:hi('CursorLineNr', '#2B91AF', s:normalbg)
    call s:hi('CursorLine', 0, '#99CCCC')
    call s:hi('Visual', 0, '#7ABBD2')
    call s:hi('Folded', 0, '#afd7ff')
    call s:hi('Conceal', 0, s:normalbg)
    call s:hi('Keyword', '#f92672', 0)
endf

fun! s:ColorTerm()
    if g:colors_name!='PaperColor'|return|endif
	call s:clear('TabLine', 'TabLineFill')
    hi Visual ctermfg=None
endf

if has('gui_running')
    au VimEnter,ColorScheme * call <SID>ColorGui()
else
    au VimEnter,ColorScheme * call <SID>ColorTerm()
endif
