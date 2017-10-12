
let s:menu = popup#menu('Search')
let s:vmenu = popup#menu('Search-Visual')

call s:menu.additem('s', 'EasyMotion-S2 <c-\>', "\<Plug>(easymotion-s2)")
call s:menu.additem('d', 'Current Directory', {->printf(':vim /%s/ %%:h/*', input('pattern: '))})

call s:vmenu.additem('d', 'Current directory', ":vim /\<c-r>" . '"/ %:h/*')
call s:vmenu.additem('.', 'The text' , 'y/\V'."\<c-r>\"")
call s:vmenu.additem('w', 'The word' , 'y/\V\<'."\<c-r>".'"\>')
call s:vmenu.additem('e', 'Replace text' , 'y:%s/\V'."\<c-r>".'"/')
call s:vmenu.additem('o', 'Replace word' , 'y:%s/\V\<'."\<c-r>".'"\>/')
call s:vmenu.additem('/', 'Replace /', ":s/\<c-r>///g\<left>\<left>")
