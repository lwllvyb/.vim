let all = {
    \ 'left': [['mode', 'paste'],
    \           ['readonly', 'filename', 'modified']],
    \ 'right': [['lineinfo'], ['percent'],
    \            ['fileformat', 'fileencoding', 'filetype']] }

let g:lightline = {
    \ 'active': all,
    \ 'inactive': all,
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
    \ 'component_function': {'filetype': 'MyFiletype', 'fileformat': 'MyFileformat'}
    \ }

let g:lightline.colorscheme = get({
        \ 'one': 'one',
        \ 'one-dark': 'one-dark'
        \ },
    \ get(g:, 'COLORSCHEME', 'one'))
let g:lightline.enable = {'statusline': 1, 'tabline': 0}

fun! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&ft) ? &ft . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endf

fun! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endf
