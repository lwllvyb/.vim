
if !has('nvim') && has('win32')
    func! GuiSetAlpha(n)
        call libcallnr('vimtweak64.dll', 'SetAlpha', a:n)
    endf

    func! GuiSetTopMost(b)
        call libcallnr('vimtweak64.dll', 'EnableTopMost', a:b)
    endf

    let g:GuiWindowFullScreen = 0
    func! GuiWindowFullScreen(b)
        call libcallnr('vimtweak64.dll', 'EnableCaption', a:b)
        let g:GuiWindowFullScreen = a:b
    endf

    let g:GuiWindowMaximized = getwinposx() < 0 && getwinposy() < 0
    func! GuiWindowMaximized(b)
        call libcallnr('vimtweak64.dll', 'EnableMaximize', a:b)
        let g:GuiWindowMaximized = getwinposx() < 0 && getwinposy() < 0
    endf
endif
