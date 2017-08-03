set fdm=syntax fdl=3

if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

nmap <buffer><m-o> viw<m-o>
vnoremap <buffer><m-o> yocout << <c-r>" << endl;<esc>
call dict#addl('c', 'cpp')

so <sfile>:h/cxx.vim
