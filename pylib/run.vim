" =============================================================================
" Filename:     plugin/pylib/run.vim
" Author:       luzhlon
" Function:     
" Last Change:  
" =============================================================================

py3 from process import Process

fun! RunTask(cmd, ...)
py3 p = Process(vim.eval('a:cmd'))
if a:0 > 0
    py3 _output = vim.Function(vim.eval('a:1'))
    py3 p.readline(lambda p, l: _output(l))
endif
if a:0 > 1
    py3 _quit = vim.Function(vim.eval('a:2'))
    py3 p.on_quit = lambda p: _quit(str(p.returncode))
endif
endf

fun! s:onout(l)
    cadde a:l
    redraw
endf
fun! s:onquit(exitcode)
    let code = 0 + a:exitcode
    if code
        if exists('g:run_on_failure')
            exe g:run_on_failure
        else
            cwindow
        endif
    elseif exists('g:run_on_success')
        exe g:run_on_success
    endif
endf

fun! s:Run(cmd)
    if empty(a:cmd)|return|endif
    let cmd = join([&shell, &shcf, a:cmd])
    cexpr ''
    call RunTask(cmd, 's:onout', 's:onquit')
endf

com! -nargs=* -complete=shellcmd RunTask call <SID>Run('<args>')
