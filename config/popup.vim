
let g:popup#upkey = "\<c-h>"

map  <expr><m-.> popup#last()
map! <expr><m-.> popup#last()

nmap <expr><m-e> popup#('edit#n')
xmap <expr><m-e> popup#('edit#v')
imap <expr><m-e> popup#('edit#i')

nmap <expr><m-s> popup#('search#n')
xmap <expr><m-s> popup#('Search#v')

nmap <expr><m-f> popup#('common#file')
nmap <expr><m-g> popup#('common#goto')

nmap <expr><m-x> popup#('xmake')

imap <expr><m-i> popup#('insert')

nmap <expr><silent>\ popup#('leader#n')
nmap <expr><silent><m-\> popup#('leader#tools')

nmap <expr><space> popup#('util#n')
xmap <expr><space> popup#('util#v')

nmap <expr><silent><m-w> popup#('window#n')
