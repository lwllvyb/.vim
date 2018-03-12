
" Run command line {...} with administrator privilige
fun! sys#sh#admin(...)
    let cmdline = join(map(copy(a:000), {i,v->shellescape(v)}))
    let tf = tempname() . '.vbs'
    call writefile([
        \ 'set uac = CreateObject("Shell.Application")',
        \ 'WScript.StdOut.Write "Input command: "',
        \ 'uac.ShellExecute WScript.StdIn.ReadLine(), "", "", "runas", 1',
        \ 'WScript.Quit'
    \ ], tf)
    call system('cscript ' . shellescape(tf) . "\n", cmdline)
endf
