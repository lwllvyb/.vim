
set isk&

setl cms=--\ %s
vnoremap <buffer><m-o> yoprint()<esc>P

let b:help_iskeyword = '@,48-57,_,192-255,#,-,.'

let s:path = expand('<sfile>:p')
call setbufvar('%', '&dictionary', s:path . '/lua.dict')
