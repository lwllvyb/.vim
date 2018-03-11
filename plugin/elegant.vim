" =============================================================================
" Filename:    plugin/elegant.vim
" Author:      luzhlon
" Date:        2017-10-09
" Description: Transparent Visual and Cursor background-color
" =============================================================================

fun! s:hi(item, opt)
    let args = values(map(a:opt, {k,v->empty(v) ? '': printf('%s=%s', k, v)}))
    let args = join(args)
    if args =~ '^\s*$' | return | endif
    " echo join(args) args
    exe 'hi!' a:item args
endf

fun! s:setcolor()
    let cur_bg_gui = synIDattr(hlID('Cursor'), 'bg', 'gui')
    let vis_bg_gui = synIDattr(hlID('Visual'), 'bg', 'gui')
    let cur_bg_term = synIDattr(hlID('Cursor'), 'bg', 'cterm')
    let vis_bg_term = synIDattr(hlID('Visual'), 'bg', 'cterm')
    let bg_gui = synIDattr(hlID('Normal'), 'bg', 'gui')
    let bg_term = synIDattr(hlID('Normal'), 'bg', 'cterm')
    " Make Visual and Cursor Transparent
    hi clear Cursor
    hi clear Visual
    call s:hi('Cursor', {'guibg': cur_bg_gui, 'ctermbg': cur_bg_term})
    call s:hi('Visual', {'guibg': vis_bg_gui, 'ctermbg': vis_bg_term})
    " Make EndOfBuffer character '~' invisible
    call s:hi('EndOfBuffer', {'guifg': bg_gui, 'ctermfg': bg_term})
    " let vertbg = synIDattr(hlID('VertSplit'), 'fg', 'gui')
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
