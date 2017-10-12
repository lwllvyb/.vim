
let s:menu = popup#menu('Build')

call s:menu.additem('q', 'QuickFix' , ":bel copen 8\<cr>")
call s:menu.additem('a', 'Build all', ":XMake\<cr>")
call s:menu.additem('b', 'Build ...', ":XMake build ")
call s:menu.additem('r', 'Build&Run', ":XMake run ")
call s:menu.additem('g', 'Generate', ":XMake project -k ")
call s:menu.additem('c', 'Clean', ":XMake clean\<cr>")

fun! popup_menu#build#normal()
    return s:menu.popup()
endf
