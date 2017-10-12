
" let g:NERDTreeDisableFileExtensionHighlight = 0
" let g:NERDTreeDisableExactMatchHighlight = 0
" let g:NERDTreeDisablePatternMatchHighlight = 0

let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"

let g:NERDTreeExtensionHighlightColor = {
    \ 'conf'     : s:beige,
    \ 'ini'      : s:beige,
    \ 'yml'      : s:beige,
    \ 'bat'      : s:beige,
    \ 'snippets' : s:aqua,
    \ }

let g:NERDTreeExactMatchHighlightColor = {
    \ 'vimrc': s:green,
    \ '.gitignore': s:orange
    \ }
