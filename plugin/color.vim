" =============================================================================
" Filename:    plugin/color.vim
" Author:      luzhlon
" Date:        2017-10-09
" Description: Transparent Visual and Cursor background-color
" =============================================================================

fun! s:setcolor()
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

    if &bg == 'light'
        hi NormalDeep guibg=#f0f0f0
        hi CursorLineDeep guibg=#007ACC
        hi NormalQF guibg=#E6E7E8
        hi NormalHelp guibg=#F0E9DF
    else
        hi NormalDeep guibg=#252526
        hi CursorLineDeep guibg=#3F3F46
        hi NormalQF guibg=#3F3F40
        hi NormalHelp guibg=#3F3F40
    endif
endf

call s:setcolor()
au ColorScheme * call <SID>setcolor()
