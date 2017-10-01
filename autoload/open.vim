
if has('win32')
    let s:env = 'windows'
elseif executable('cmd.exe')
    let s:env = 'wsl'
else
    let s:env = 'unix'
endif

fun! open#(f)
    let f = shellescape(a:f)
    if s:env == 'windows'
        sil exe '!rundll32 url.dll,FileProtocolHandler' f
    elseif s:env == 'wsl'
        sil exe '!rundll32.exe url.dll,FileProtocolHandler' f
    else
        sil exe '!xdg-open' f
    endif
endf

fun! open#cur_file()
    let file = expand('<cfile>')
    if file =~ '^\.'
        let file = expand('%:h') . '/' . file
        let file = simplify(file)
    endif
    call open#(file)
endf

fun! open#bash()
    let t = executable('open-wsl') ? 'open-wsl': 'bash'
    if s:env == 'windows'
        sil exe '!start' t
    elseif s:env = 'wsl'
        sil exe '!cmd.exe /c start' t
    else
        sil !gnome-terminal -e bash
    endif
endf

fun! open#powershell()
    if s:env == 'windows'
        sil !start powershell
    elseif s:env = 'wsl'
        sil !cmd.exe /c start powershell
    endif
endf

fun! open#cmd()
    if s:env == 'windows'
        sil !start cmd
    elseif s:env = 'wsl'
        sil !cmd.exe /c start cmd
    endif
endf

fun! open#curdir()
    if s:env ==  'windows'
        sil !start explorer "%:p:h"
    elseif s:env == 'wsl'
        sil !cmd.exe /c start explorer .
    else
    endif
endf

fun! open#reopen_curfile()
    if empty(&bt)
        call open#reopen(expand('%:p'))
    else
        echoerr 'Current buffer is not a file'
    endif
endf

fun! open#reopen(...)
    let path = v:progpath
    if has('nvim') && g:GuiLoaded
        let t = fnamemodify(path, ':h') . '/nvim-qt'
        if executable(path) | let path = t | endif
    endif
    let cmd = [path] + copy(a:000)
    call map(cmd, {i,v->empty(v)?'': shellescape(v)})
    call s:restart_task(join(cmd))
    confirm qa
endf

fun! s:restart_task(cmd)
    let cmd = has('win32') ? iconv(a:cmd, 'utf8', 'gbk'): a:cmd
    let pid = getpid()
    let cont = ['@echo off', 'title.', ':WAIT',
            \ printf('tasklist /FI "PID eq %d"|find "%d"', pid, pid),
            \ 'if %ERRORLEVEL% EQU 0 goto WAIT', cmd, 'exit']
    if has('win32')
        call map(cont, {i,v->v . "\r"})
    endif
    let tf = tempname() . '.cmd'
    if has('nvim') | let tf = fnamemodify(tf, ':h') . '.cmd' | endif
    call writefile(cont, tf)
    if has('nvim')
        let j = jobstart('cmd')
        call jobsend(j, printf("call %s\r\n", tf))
    else
        call job_start(['cmd', '/c', 'call', tf], {'stoponexit': ''})
    endif
endf
