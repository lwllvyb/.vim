func! s:SetAlpha(n)
    call libcallnr('vimtweak64.dll', 'SetAlpha', a:n)
endf
func! EnableCaption(b)
    call libcallnr('vimtweak64.dll', 'EnableCaption', a:b)
endf
func! EnableTopMost(b)
    call libcallnr('vimtweak64.dll', 'EnableTopMost', a:b)
endf
func! EnableMaximize(b)
    call libcallnr('vimtweak64.dll', 'EnableMaximize', a:b)
endf

com! -nargs=1 SetAlpha call <SID>SetAlpha(<args>)
com! Maximize call EnableMaximize(1)
