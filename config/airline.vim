let g:airline_theme = has('gui_running') ? 'solarized' : 'badwolf'
"加载列表里的扩展
let g:airline_extensions = ['tabline']

"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols_branch = ''
"let g:airline_symbols_readonly = ''
"let g:airline_symbols_linenr = ''

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = '|'
let g:airline#extensions#tabline#show_tabs = 1          "显示标签页
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_idx_format = {
    \ '0': '0:', '1': '1:', '2': '2:', '3': '3:',
    \ '4': '4:', '5': '5:', '6': '6:', '7': '7:',
    \ '8': '8:', '9': '9:'}

nmap <m-1> <Plug>AirlineSelectTab1
nmap <m-2> <Plug>AirlineSelectTab2
nmap <m-3> <Plug>AirlineSelectTab3
nmap <m-4> <Plug>AirlineSelectTab4
nmap <m-5> <Plug>AirlineSelectTab5
nmap <m-6> <Plug>AirlineSelectTab6
nmap <m-7> <Plug>AirlineSelectTab7
nmap <m-8> <Plug>AirlineSelectTab8
nmap <m-9> <Plug>AirlineSelectTab9
