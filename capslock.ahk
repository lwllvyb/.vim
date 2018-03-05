
SetCapsLockState, AlwaysOff

;======================================
; Arrow key
;======================================

CapsLock & n:: Send % GetKeyState("LAlt") ? "{PgDn}": "{down}"
CapsLock & p:: Send % GetKeyState("LAlt") ? "{PgUp}": "{up}"

CapsLock & f:: Send % GetKeyState("RAlt") ? GetKeyState("LCtrl") ? "^+{right}": "^{right}": "{right}"
CapsLock & b:: Send % GetKeyState("RAlt") ? GetKeyState("LCtrl") ? "^+{left}": "^{left}": "{left}"
CapsLock & e:: Send % GetKeyState("RAlt") ? GetKeyState("LCtrl") ? "^+{end}": "^{end}": "{end}"
CapsLock & a:: Send % GetKeyState("RAlt") ? GetKeyState("LCtrl") ? "^+{home}": "^{home}": "{home}"
CapsLock & d:: Send % GetKeyState("RAlt") ? "^{delete}": "{delete}"
CapsLock & w:: Send % GetKeyState("RAlt") ? "^{BS}": "^w"

CapsLock & h:: Send % GetKeyState("LAlt") ? "!{left}": "{BS}"
CapsLock & l:: Send % GetKeyState("LAlt") ? "!{right}": "^l"
CapsLock & j:: Send % GetKeyState("LAlt") ? "!{down}": "^j"
CapsLock & k::
    WinGetClass cls, A
    if (cls = "ConsoleWindowClass")
        Send ^{end}
    else
        Send % GetKeyState("LAlt") ? "!{up}": "+{end}{BS}"
    return
CapsLock & u::
    WinGetClass cls, A
    if (cls = "ConsoleWindowClass")
        Send ^{home}
    else
        Send +{home}{BS}
    return

;=======================================
; CapsLock + * ====> Ctrl + *
;=======================================

CapsLock & ':: Send ^'
CapsLock & ,:: Send ^,
CapsLock & -:: Send ^-
CapsLock & .:: Send ^.
CapsLock & /:: Send ^/
; CapsLock & 0:: Send ^0
; CapsLock & 1:: Send ^1
; CapsLock & 2:: Send ^2
; CapsLock & 3:: Send ^3
; CapsLock & 4:: Send ^4
; CapsLock & 5:: Send ^5
; CapsLock & 6:: Send ^6
; CapsLock & 7:: Send ^7
; CapsLock & 8:: Send ^8
; CapsLock & 9:: Send ^9
; CapsLock & \;:: Send ^\;
CapsLock & <:: Send ^<
CapsLock & =:: Send ^=
CapsLock & >:: Send ^>
CapsLock & ?:: Send ^?
CapsLock & @:: Send ^@
CapsLock & [:: Send ^[
CapsLock & \:: Send ^\
CapsLock & ]:: Send ^]
CapsLock & `:: Send ^`
CapsLock & c:: Send ^c
CapsLock & g:: Send ^g
CapsLock & i:: Send ^i
CapsLock & m:: Send ^m
CapsLock & o:: Send ^o
CapsLock & q:: Send ^q
CapsLock & r:: Send ^r
CapsLock & s:: Send ^s
CapsLock & t:: Send ^t
CapsLock & v:: Send ^v
CapsLock & x:: Send ^x
CapsLock & y:: Send ^y
CapsLock & z:: Send ^z

CapsLock & BS::     Send ^{BS}
CapsLock & Enter::  Send ^{Enter}
CapsLock & Left::   Send ^{Left}
CapsLock & Right::  Send ^{Right}
CapsLock & Down::   Send ^{Down}
CapsLock & Up::     Send ^{Up}

CapsLock:: Send {ESC}
