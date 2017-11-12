
if !has('nvim') | finish | endif
if !has('win32') | finish | endif
if !has('python3') | finish | endif

if exists('g:GuiWindowMaximized') && g:GuiWindowMaximized
    finish
endif

fun! s:set_size(...)
py3 << EOF
from ctypes import *
u32 = WinDLL('user32.dll')

# Fix me
LEFT = 160
TOP = 50
WIDTH = 888
HEIGHT = 666

GetForegroundWindow = u32.GetForegroundWindow
GetSystemMetrics = u32.GetSystemMetrics
SetWindowPos = u32.SetWindowPos
GetWindowRect = u32.GetWindowRect
# u32.MessageBoxA(0, hex(cw), hex(cw), 0)

class Rect(Structure):
    _fields_ = [
        ('left', c_long),
        ('top', c_long),
        ('bottom', c_long),
        ('right', c_long)
    ]

GetWindowRect.argtypes = [c_long, Rect]

rect = Rect()
cw = GetForegroundWindow()

# GetWindowRect(cw, rect)
SetWindowPos(cw, 0, LEFT, TOP, WIDTH, HEIGHT, 0)
EOF
endf

fun! s:start()
    " call timer_start(50, funcref('s:set_size'))
    call s:set_size()
endf

au GUIEnter * call <sid>start()
