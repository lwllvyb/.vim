
if has('gui_running')
    let s:fgpre = 'guifg='
    let s:bgpre = 'guibg='
else
    let s:fgpre = 'ctermfg='
    let s:bgpre = 'ctermbg='
endif

fun! s:hi(x, fg, bg, ...)
    let opt = ''
    let fg = empty(a:fg) ? '': s:fgpre . a:fg
    let bg = empty(a:bg) ? '': s:bgpre . a:bg
    if a:0
        if a:1 == 'clear'
            exe 'hi' 'clear' a:x
        else
            let opt = a:1
        endif
    endif
    exe 'hi' (a:x) fg bg opt
endf

let s:normalfg = '#494b53'
let s:normalbg = '#fafafa'
let s:cursorbg = '#526fff'

fun! s:DoColor()
    if GuiRunning()
        let s:fgpre = 'guifg='
        let s:bgpre = 'guibg='
        if &bg != 'light' | return | endif
        call s:hi('TabLine', s:normalfg, s:normalbg)
        call s:hi('TabLineFill', 0, s:normalbg, 'clear')
        call s:hi('Cursor', 'White', s:cursorbg)
        call s:hi('Normal', s:normalfg, s:normalbg)
        call s:hi('NonText', '#a0a1a7', s:normalbg)
        call s:hi('LineNr', '#b2b2b2', s:normalbg)
        call s:hi('TabLineSel', 'White', '#4078f2', 'gui=bold,underline')
        call s:hi('MatchParen', '#e45649', '#f0f0f0', 'gui=bold,underline')
        call s:hi('StatusLine', 'White', '#a0a1a7')
        call s:hi('StatusLineNC', s:normalfg, '#f0f0f0')
        call s:hi('VertSplit', s:normalbg, 0)
        " call s:hi('CursorLineNr', '#2B91AF', s:normalbg)
        " call s:hi('CursorLine', 0, s:normalbg)
        call s:hi('Visual', 0, '#d0d0d0', 'clear')
        call s:hi('Folded', 0, '#afd7ff')
        call s:hi('Conceal', 0, s:normalbg)
        call s:hi('Keyword', '#f92672', 0)
        hi! link pythonBuiltinObj Constant
        hi! link pythonBuiltinFunc Operator
    else
        hi clear TabLine
        hi clear TabLineFill
        call s:hi('Visual', 'NONE', 0)
    endif
endf

" au ColorScheme PaperColor call <SID>DoColor()
