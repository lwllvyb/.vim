
let g:popup#upkey = "\<c-h>"

map  <expr><m-.> popup#last()
map! <expr><m-.> popup#last()

nmap <expr><m-e> popup#('edit')
vmap <expr><m-e> popup#('edit-v')
imap <expr><m-e> popup#('edit-i')

nmap <expr><m-s> popup#('search')
vmap <expr><m-s> popup#('Search-v')

nmap <expr><m-f> popup#('file')
nmap <expr><m-g> popup#('goto')

nmap <expr><m-x> popup#('xmake')

imap <expr><m-i> popup#('insert')

nmap <expr><silent>\ popup#('leader')
nmap <expr><silent><m-\> popup#('tools')

nnoremap <expr><space> popup#('util')
vnoremap <expr><space> popup#('util-v')

nmap <expr><silent><m-w> popup#('window')

let g:popup_menus = {
    \ 'edit': 'pmenu#edit#n',
    \ 'edit-v': 'pmenu#edit#v',
    \ 'edit-i': 'pmenu#edit#i',
    \ 'search': 'pmenu#search#n',
    \ 'search-v': 'pmenu#search#v',
    \ 'file': 'pmenu#common#file',
    \ 'goto': 'pmenu#common#goto',
    \ 'util': 'pmenu#util#n',
    \ 'util-v': 'pmenu#util#v',
    \ 'window': 'pmenu#window#n',
    \ 'leader': 'pmenu#leader#n',
    \ 'tools': 'pmenu#leader#tools',
    \ 'xmake': 'pmenu#xmake#n',
    \ }
