
let g:UltiSnipsExpandTrigger = '<c-\>'
let g:UltiSnipsListSnippets = '<c-r><c-\>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsEditSplit = "vertical"

let g:ultisnips_entered = 0

au User UltiSnipsEnterFirstSnippet let g:ultisnips_entered = 1
au User UltiSnipsExitLastSnippet let g:ultisnips_entered = 0

inoremap <silent>( <c-r>=UltiSnips#Anon('($1)')<cr>
inoremap <silent>[ <c-r>=UltiSnips#Anon('[$1]')<cr>
inoremap <silent>{ <c-r>=UltiSnips#Anon('{$1}')<cr>
inoremap <silent>` <c-r>=UltiSnips#Anon('`$1`')<cr>
inoremap <silent>" <c-r>=UltiSnips#Anon('"$1"')<cr>
inoremap <silent>' <c-r>=UltiSnips#Anon("'$1'")<cr>
