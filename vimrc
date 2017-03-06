" =============================================================================
" Filename:     vimrc
" Author:       luzhlon
" Description:  vim startup script
" Last Change:  2017/2/20
" =============================================================================

so <sfile>:h/option.vim
so <sfile>:h/env.vim
"Load specifitic plugin
fun! LoadPlugin(p, ...)
    call plug#(a:p)
    if a:0|exe 'ru' 'config/'.a:1.'.vim'|endif
endf
"load configuration file from current directory
fun! LoadCurDir()
    call lib#so(getcwd().'/.rc.vim')
endf

call plug#begin('~/.vim/.plugs')
com! -nargs=1 PlugLoad call LoadPlugin(<args>)

    PlugLoad   'Lokaltog/vim-easymotion' , 'easymotion'
    PlugLoad   'Shougo/deoplete.nvim'    , 'deoplete'
    PlugLoad   'drmingdrmer/xptemplate'  , 'xptemplate'
    PlugLoad   'junegunn/vim-easy-align' , 'easyalign'
    PlugLoad   'scrooloose/nerdtree'     , 'nerdtree'
    PlugLoad   'tpope/vim-surround'      , 'surround'
    PlugLoad   'vim-airline/vim-airline' , 'airline'
    PlugLoad   'davidhalter/jedi-vim'    , 'jedi'
    PlugLoad   'luzhlon/popup.vim'
    PlugLoad   'luzhlon/util.vim'
    PlugLoad   'luzhlon/vim-markdown'    , 'markdown'
    PlugLoad   'Rip-Rip/clang_complete'  , 'clang'
    "PlugLoad   'Tagbar'
    " PlugLoad   'chrisbra/csv.vim'

    call LoadCurDir()

delc PlugLoad
call plug#end()

syntax on
filetype plugin indent on
