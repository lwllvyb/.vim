
let g:lightline = {
    \ 'component': {
    \   'readonly': '%{&ft=="help"?"":&ro?"":""}',
    \   'modified': '%{&ft=="help"?"":&mod?"*":&modifiable?"":"-"}',
    \   'lineinfo': '⭡ %3l:%-2v',
    \   'logo': '  ',
    \ },
    \ 'component_expand': {
    \   'bufline': 'bufline#lightline',
    \ },
    \ 'component_type': {
    \   'bufline': 'tabsel',
    \   'tabs': 'tabsel', 'close': 'raw'
    \ },
    \ 'component_visible_condition': {
    \   'readonly': '(&ft!="help"&& &ro)',
    \   'modified': '(&ft!="help"&&(&mod||!&modifiable))',
    \ },
    \ 'separator': {'left': '', 'right': ''},
    \ 'subseparator': {'left': '', 'right': ''},
    \ }

" Statusline (active && inactive) {{{
let g:lightline.active = {
    \ 'left': [['mode', 'paste'],
    \           ['readonly', 'filename', 'modified']],
    \ 'right': [['lineinfo'], ['percent'],
    \            ['fileformat', 'fileencoding', 'filetype']]
    \ }
let g:lightline.inactive = g:lightline.active
" }}}

" Tabline => Bufline {{{
    " \ 'left': [['logo'], ['bufline']],
let g:lightline.tabline = {
    \ 'left': [['logo'], ['bufline']],
    \ 'right': [['close']]
    \ }
" }}}

" The lightline's theme {{{
" powerline、wombat、jellybes、solarized、Dracula、one、landscape
" molokai nord OldHope PaperColor seoul256 Tomorrow darcula 16color materia
" material default
let g:lightline.colorscheme = &bg == 'dark' ?
        \ get({
            \ 'amcolors': 'powerline',
            \ 'one-dark': 'one',
            \ 'neodark': 'one',
        \ }, COLORSCHEME, 'powerline') :
        \ get({
            \ 'one': 'materia',
            \ 'one-dark': 'one',
            \ 'neodark': 'one',
        \ }, COLORSCHEME, 'solarized')
" }}}

let g:lightline.enable = {'statusline': 1, 'tabline': 1}

" let g:lightline.component_function = {'filetype': 'MyFiletype', 'fileformat': 'MyFileformat'}

" fun! MyFiletype()
  " return winwidth(0) > 70 ? (strlen(&ft) ? &ft . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
" endf
" 
" fun! MyFileformat()
  " return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
" endf
