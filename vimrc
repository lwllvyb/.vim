" =============================================================================
" Filename:     vimrc
" Author:       luzhlon
" Description:  vim startup script
" Last Change:  2017/2/20
" =============================================================================

com! -nargs=+ Source so <sfile>:h/<args>
Source option.vim

let $CONFROOT = expand('<sfile>:h')
" let &rtp .= ',' . $CONFROOT

let lconf = glob('~/.config/local.vim')
if filereadable(lconf)
    exe 'so' lconf
" else | au VimEnter * echo 'Please config your local config' lconf
endif

fun! GuiRunning()
    return has('gui_running') || has('nvim') && exists('GuiFont')
endf

if !has('nvim')
    Source alt-mapping.vim
endif

Source plugs.vim
filetype plugin indent on
syntax enable

if has('gui_running')
    Source gvim.vim
endif
