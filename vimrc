" =============================================================================
" Filename:     vimrc
" Author:       luzhlon
" Description:  vim startup script
" Last Change:  2017/2/20
" =============================================================================

so <sfile>:h/option.vim
so <sfile>:h/env.vim

let s:path = expand('<sfile>:p:h')
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

call plug#begin('~/.vim/.plugs')
com! -nargs=1 PlugLoad call LoadPlugin(<args>)

    PlugLoad   'Lokaltog/vim-easymotion' , 'easymotion'
    PlugLoad   'Shougo/deoplete.nvim'    , 'deoplete'
    PlugLoad   'drmingdrmer/xptemplate'  , 'xptemplate'
    PlugLoad   'junegunn/vim-easy-align' , 'easyalign'
    PlugLoad   'scrooloose/nerdtree'     , 'nerdtree'
    PlugLoad   'tpope/vim-surround'      , 'surround'
"    PlugLoad   'vim-airline/vim-airline' , 'airline'
    PlugLoad   'davidhalter/jedi-vim'    , 'jedi'
    PlugLoad   'luzhlon/hack.vim'
    PlugLoad   'luzhlon/vim-markdown'    , 'markdown'
    PlugLoad   'Rip-Rip/clang_complete'  , 'clang'
    "PlugLoad   'Tagbar'
    " PlugLoad   'chrisbra/csv.vim'

    call LoadCurDir()

delc PlugLoad
call plug#end()

syntax on
filetype plugin indent on
