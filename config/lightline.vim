
let g:lightline = {
    \ 'component': {
    \   'readonly': '%{&ft=="help"?"":&ro?"[R0]":""}',
    \   'modified': '%{&ft=="help"?"":&mod?"*":&modifiable?"":"-"}',
    \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
    \ },
    \ 'component_visible_condition': {
    \   'readonly': '(&ft!="help"&& &ro)',
    \   'modified': '(&ft!="help"&&(&mod||!&modifiable))',
    \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
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
let g:lightline.tabline = {
    \ 'left': [['bufferinfo'],
             \ ['bufferbefore', 'buffercurrent', 'bufferafter']
             \ ],
    \ 'right': [['close']],
    \ }
" }}}

" The lightline's theme {{{
" powerline、wombat、jellybes、solarized、Dracula、one、landscape
let g:lightline.colorscheme = get({
        \ 'one': 'one',
        \ 'one-dark': 'one',
        \ 'neodark': 'one'
        \ },
    \ get(g:, 'COLORSCHEME', 'one'))
" }}}

let g:lightline.enable = {'statusline': 1, 'tabline': 0}

" let g:lightline.component_function = {'filetype': 'MyFiletype', 'fileformat': 'MyFileformat'}

" fun! MyFiletype()
  " return winwidth(0) > 70 ? (strlen(&ft) ? &ft . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
" endf
" 
" fun! MyFileformat()
  " return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
" endf
