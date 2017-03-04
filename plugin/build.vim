" =============================================================================
" Filename:     plugin/build.vim
" Author:       luzhlon
" Function:     使用scons构建C/C++程序的插件
" Last Change:  2017/3/5
" =============================================================================

py3 << EOF
import subprocess
from collections import deque
from threading import Thread

g_si = subprocess.STARTUPINFO()
g_si.dwFlags = subprocess.STARTF_USESHOWWINDOW
g_si.wShowWindow = subprocess.SW_HIDE

PIPE = subprocess.PIPE
class AsynRunner(Thread):
    def __init__(self, cmd, cb):
        Thread.__init__(self)
        self.p = subprocess.Popen(cmd, stdout=PIPE, stderr=PIPE, startupinfo=g_si)
        self.cb = cb
    def run(self):
        while 1:
            l = self.p.stdout.readline()
            if l:
                self.l = l.decode('gbk', errors='replace')
                self.cb(self.l)
            else:
                break
EOF

fun! AsynRunner(cmd, cb)
    py3 AsynRunner(vim.eval('a:cmd'), vim.Function(vim.eval('a:cb'))).start()
endf

fun! s:put2qflist(l)
    cadde a:l
    redraw
endf

fun! s:Build()
    call AsynRunner('cmd /c scons', 's:put2qflist')
endf

com! Build call <SID>Build()
