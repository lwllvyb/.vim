
set uac = CreateObject("Shell.Application")
Dim prog, param
WScript.StdOut.Write "Input program: "
prog = WScript.StdIn.ReadLine()

WScript.StdOut.Write "Input params: "
param = WScript.StdIn.ReadLine()

uac.ShellExecute prog, param, "", "runas", 1
WScript.Quit
