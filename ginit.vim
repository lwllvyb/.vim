" =============================================================================
" Filename:    ginit.vim
" Author:      luzhlon
" Date:        2017-08-28
" Description: For GUI of vim or neovim
" =============================================================================

" ----------------------- Config -------------------------
let s:font = 'FantasqueSansMono NF'
let s:fontsize = 12
let s:linespace = 0

" Code {{{
let s:fontstr = s:font . (exists('s:fontsize') ? ':h' . s:fontsize: '')

fun! s:gvim_init()
    let &guifont = s:fontstr

    if exists('s:linespace')
        let &linespace = s:linespace
    endif

    set mousemodel=popup_setpos
    let &guioptions = ''
endf

fun! s:gnvim_init()
    exe 'GuiFont!' s:fontstr

    if exists('s:linespace')
        exe 'GuiLinespace' s:linespace
    endif

    doautocmd GUIEnter
endf

try
    if has('nvim')
        call s:gnvim_init()
    else
        call s:gvim_init()
    endif
catch
    echom v:errmsg
endt
" }}}
