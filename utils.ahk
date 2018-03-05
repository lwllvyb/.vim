
RAlt & x::
    WinGet, IsMax, MinMax, A
    if IsMax = 1
        WinRestore, A
    else
        WinMaximize, A
    return

RAlt & z:: WinMinimize, A
RAlt & c:: WinClose, A
RAlt & f:: Send ^{right}
RAlt & b:: Send ^{left}
RAlt & d:: Send ^{delete}

RCtrl:: Send {AppsKey}

^!h:: MouseMove -30, 0, 0, R
^!l:: MouseMove 30, 0, 0, R
^!j:: MouseMove 0, 30, 0, R
^!k:: MouseMove 0, -30, 0, R
^!i:: MouseClick Left
^!o:: MouseClick Right

; RAlt:: Send !{tab}

; F12::
;     WinGetClass, class, A
;     MsgBox, The active window's class is "%class%".
;     return
