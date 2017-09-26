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
endif

if !has('nvim')
    Source alt-mapping.vim
endif

Source plugs.vim
filetype plugin indent on
syntax enable

" For vim
if has('gui_running')
    Source gvim.vim
endif

" For neovim
fun! GuiRunning()
    return exists('g:GuiLoaded') && g:GuiLoaded == 1 || has('gui_running')
endf

if exists('g:COLORSCHEME')
    exe 'au VimEnter * nested colorscheme' g:COLORSCHEME
endif
