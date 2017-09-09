" =============================================================================
" Filename:     plugin/xmake.vim
" Author:       luzhlon
" Function:     commands about xmake
" Last Change:  2017/7/20
" =============================================================================
" Arguments of 'xmake'
let s:xmake_args = [ 'run',
                   \ 'config', 'global',
                   \ 'create', 'package',
                   \ 'install', 'uninstall',
                   \ 'build', 'clean',
                   \ 'project',
                   \ 'doxygen',
                   \ 'app2ipa']
" Arguments of 'xmake create'
let s:create_args = [
            \ '--name=', '-n',
            \ '--language=', '-l',
            \ '--template=', '-t']
" Arguments of 'xmake config'
let s:config_args = [
            \ '--verbose=', '-v',
            \ '--plat=', '-p',
            \ '--arch=', '-a',
            \ '--mode=', '-m',
            \ '--kind=', '-k',
            \ '--buildir=', '-o']
let s:plat_args = ['android', 'iphoneos', 'linux', 'macos', 'mingw', 'watchos', 'windows']
let s:language_args = ['c', 'c++', 'dlang', 'objc', 'objc++', 'rust', 'swift']
" Get the last operation
fun! s:lastarg(args)
    let i = -1
    try | while 1
        let a = a:args[i]
        if a =~ '^-' | return a | endif
        let i -= 1
    endw | endt
    return ''
endf
" Function to complete the xmake args
fun! s:xmake_complete(a, c, p)
    let args = split(strpart(a:c, 0, a:p), '\s\+')
    let op = len(args) > 1 ? args[1] : ''
    let larg = args[-1]
    let rets = []
    if op == 'run' || op == 'build'
        let rets = keys(g:xmproj['targets'])
    elseif op == 'create'
        if larg == '--language=' || larg == '-l'
            let rets = s:language_args
        else
            let rets = s:create_args
        endif
    elseif op == 'config'
        if larg == '--plat=' || larg == '-p'
            let rets = s:plat_args
        elseif larg == '--kind=' || larg == '-k'
            let rets = ['static', 'shared', 'binary']
        elseif larg == '--mode=' || larg == '-m'
            let rets = ['debug', 'release']
        else
            let rets = s:config_args
        endif
    elseif op == 'project'
        if larg == '-k'
            let rets = ['vs2013', 'vs2015', 'vs2017', 'makefile']
        elseif larg == '--mode=' || larg == '-m'
            let rets = ['debug', 'release']
        else
            let rets = ['-k', '-m']
        endif
    else
        let rets = s:xmake_args
    endif
    let g:G = [a:a, a:c, a:p, op, larg, rets]
    return filter(rets, {->v:val =~ a:a})
endf
com! -complete=customlist,<SID>xmake_complete
            \ -nargs=* XMake call xmake#xmake(<f-args>)

let s:path = expand('<sfile>:p:h')

fun! s:xmgen()
    exe 'py3file' s:path . '/xmgen.py'
endf

com! XMakeLoad call xmake#load()
com! XMakeGen  call <SID>xmgen()

let arg = argv(0)
if fnamemodify(arg, ':t') == 'xmake.lua'
    exe 'bw' arg

    if filereadable(arg)
        au VimEnter * XMakeLoad
    endif
endif

au BufWritePost xmake.lua XMakeLoad
