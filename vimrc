" =============================================================================
" Filename:     vimrc
" Author:       luzhlon
" Description:  vim startup script
" Last Change:  2017/2/20
" =============================================================================

com! -nargs=+ Source so <sfile>:h/<args>
Source option.vim
let LOG = {}

let $CONFROOT = expand('<sfile>:h')
exe 'set rtp+=' . $CONFROOT
"load configuration file from current directory
" fun! LoadCurDir()
"     let file = getcwd() . '/.rc.vim'
"     try|exe 'so' file|catch|endt
" endf

call plug#begin($CONFROOT . '/.plugs')
call plug#('Shougo/dein.vim')
call plug#end()

Source plugs.vim

syntax on
filetype plugin indent on

if has('gui_running')
    Source gvim.vim
endif
