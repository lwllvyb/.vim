" =============================================================================
" Filename:     vimrc
" Author:       luzhlon
" Description:  vim startup script
" Last Change:  2017/2/20
" =============================================================================

com! -nargs=+ Source so <sfile>:h/<args>
Source option.vim

let s:path = expand('<sfile>:p:h')
exe 'set rtp+=' . s:path
let s:confpath = s:path . '/config/'
"Load plugin and it's configuration
fun! LoadPlugin(p, ...)
    call plug#(a:p)
    if a:0 | try
        exe 'so' s:confpath.(a:1.'.vim')
    catch | endt | endif
endf
"load configuration file from current directory
fun! LoadCurDir()
    let file = getcwd() . '/.rc.vim'
    try|exe 'so' file|catch|endt
endf

call plug#begin(s:path . '/.plugs')
com! -nargs=1 PlugLoad call LoadPlugin(<args>)
    Source plugs.vim
    call LoadCurDir()
delc PlugLoad
call plug#end()

syntax on
"filetype plugin indent on

if has('gui_running')
    Source gvim.vim
endif
