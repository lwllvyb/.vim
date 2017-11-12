" =============================================================================
" Filename:     vimrc
" Author:       luzhlon
" Description:  vim startup script
" Last Change:  2017/2/20
" =============================================================================

com! -nargs=+ Source so <sfile>:h/<args>
Source option.vim

if !exists('$TEMP') && has('unix')
    let $TEMP = '/tmp'
endif

Source envs.vim
Source plugs.vim

if exists('g:COLORSCHEME')
    exe 'au VimEnter * nested colorscheme' g:COLORSCHEME
endif

if has('nvim')
    fun! GuiRunning()
        return exists('g:GuiLoaded') && g:GuiLoaded == 1 || has('gui_running')
    endf
else
    if has('gui_running')
        Source ginit.vim
    else
        Source alt-mapping.vim
    endif
endif

filetype plugin indent on
syntax enable
