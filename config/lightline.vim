let all = {
    \ 'left': [ [ 'mode', 'paste' ],
    \           [ 'readonly', 'filename', 'modified' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'percent' ],
    \            [ 'fileformat', 'fileencoding', 'filetype' ] ] }

let g:lightline = {
    \ 'colorscheme': 'one',
    \ 'active': all,
    \ 'inactive': all,
    \ 'component': {
    \   'readonly': '%{&filetype=="help"?"":&ro?"[R0]":""}',
    \   'modified': '%{&filetype=="help"?"":&mod?"*":&modifiable?"":"-"}',
    \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
    \ },
    \ 'component_visible_condition': {
    \   'readonly': '(&filetype!="help"&& &ro)',
    \   'modified': '(&filetype!="help"&&(&mod||!&modifiable))',
    \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }

let g:lightline.enable = { 'statusline': 1, 'tabline': 0 }
