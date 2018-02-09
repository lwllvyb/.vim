
let g:popup#upkey = "\<c-h>"

map  <expr><m-.> popup#last()
map! <expr><m-.> popup#last()

nmap <expr><m-e> popup#('edit#n')
xmap <expr><m-e> popup#('edit#v')
imap <expr><m-e> popup#('edit#i')

nmap <expr><m-s> popup#('search#n')
xmap <expr><m-s> popup#('search#v')

nmap <expr><m-f> popup#('file')
nmap <expr><m-w> popup#('window')
nmap <expr><m-x> popup#('xmake')

nmap <expr><silent>\ popup#('leader#n')
nmap <expr><silent><m-\> popup#('leader#tools')

nmap <expr><space> popup#('util#n')
xmap <expr><space> popup#('util#v')
