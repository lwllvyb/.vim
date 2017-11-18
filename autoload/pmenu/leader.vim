
let s:normal = pmenu#new('Leader',
    \ ['r', 'Relative', ":set rnu!\<cr>"],
    \ ['h', 'Highlist', ":set hls!\<cr>"],
    \ ['w', 'Auto wrap', ":set wrap!\<cr>"],
    \ ['c', 'Auco CD', ":set acd!\<cr>"],
    \ ['l', 'List mode', ":set list!\<cr>"],
    \ ['p', 'Paste mode', ":set paste!\<cr>"],
    \ ['a', 'Maximum window', ":call GuiWindowMaximized(!g:GuiWindowMaximized)\<cr>"],
    \ ['f', 'Full screen', ":call GuiWindowFullScreen(!g:GuiWindowFullScreen)\<cr>"],
    \ ['m', 'Mouse', ":let &mouse=&mouse==''?'a':''\<cr>"],
    \ ['v', 'Virtual edit', ":let &ve=&ve==''?'all':''\<cr>"],
    \ ['b', 'Background', ":let &bg=&bg=='dark'?'light':'dark'\<cr>"],
    \ ['a', 'Pairs completion', ":call AutoPairsToggle()\<cr>"],
    \ ['g', 'TAGBAR ...', ":TagbarToggle\<cr>"],
    \ )

let s:tools = pmenu#new('Tools', 
    \ ['a', 'All Bookmarks', "\<Plug>BookmarkShowAll"],
    \ ['b', 'Bookmark', "\<Plug>BookmarkToggle"],
    \ ['c', 'Codi', ":Codi\<cr>"],
    \ ['g', 'Goyo', ":Goyo\<cr>"],
    \ ['m', 'Matrix', ":Matrix\<cr>"],
    \ ['x', 'Hex Calc', ":call hexcalc#init()\<cr>"],
    \ ['l', 'LuaEval', ":call luaeval#()\<cr>"],
    \ )

fun! pmenu#leader#n()
    return s:normal
endf

fun! pmenu#leader#tools()
    return s:tools
endf
