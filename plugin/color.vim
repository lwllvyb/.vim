" =============================================================================
" Filename:    plugin/color.vim
" Author:      luzhlon
" Date:        2017-10-09
" Description: Transparent Visual and Cursor background-color
" =============================================================================

fun! s:setcursor()
    let cur_bg_gui = synIDattr(hlID('Cursor'), 'bg', 'gui')
    let vis_bg_gui = synIDattr(hlID('Visual'), 'bg', 'gui')
    let cur_bg_term = synIDattr(hlID('Cursor'), 'bg', 'cterm')
    let vis_bg_term = synIDattr(hlID('Visual'), 'bg', 'cterm')
    let bg_gui = synIDattr(hlID('Normal'), 'bg', 'gui')
    " Transparent Visual and Cursor
    hi clear Cursor
    hi clear Visual
    exe 'hi' 'Cursor' 'guibg=' . (empty(cur_bg_gui) ? bg_gui: cur_bg_gui) empty(cur_bg_term) ? '': 'ctermbg=' . cur_bg_term
    exe 'hi' 'Visual' 'guibg=' . vis_bg_gui empty(vis_bg_term) ? '': 'ctermbg=' . vis_bg_term
    let vertbg = synIDattr(hlID('VertSplit'), 'fg', 'gui')
    " if !empty(vertbg) | exe 'hi' 'VertSplit' 'guibg=' . vertbg | endif
endf

au ColorScheme * call <SID>setcursor()
