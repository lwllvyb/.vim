" =============================================================================
" Filename:     plugin/mapping.vim
" Author:       luzhlon
" Function:     一些有用的按键映射
" Last Change:  2017/3/9
" =============================================================================

nnoremap <Plug>(GoToVimFun) /\s*fu\(nction\)\?!\?.*<c-r>=expand('<cword>')<cr>
nnoremap <Plug>(GoToVimLet) /\s*let\s\+.*<c-r>=expand('<cword>')<cr>
nnoremap <Plug>(GoToPyDef) /\s*def\s\+<c-r>=expand('<cword>')<cr>(.*):\s*$
