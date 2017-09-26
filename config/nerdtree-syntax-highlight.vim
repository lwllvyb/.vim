
" let g:NERDTreeDisableFileExtensionHighlight = 0
" let g:NERDTreeDisableExactMatchHighlight = 0
" let g:NERDTreeDisablePatternMatchHighlight = 0

" you can add these colors to your .vimrc to help customizing
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
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'

let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
let g:NERDTreeSyntaxDisableDefaultExtensions = 1

" this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor = {
    \ 'css': s:beige, 'cpp': s:blue, 'vim': s:green,
    \ 'md': s:salmon, 'py': s:darkOrange,
    \ 'js': s:orange, 'html': s:pink, 'png': s:purple
    \ }

let g:NERDTreeExactMatchHighlightColor = {'.gitignore': s:git_orange}
