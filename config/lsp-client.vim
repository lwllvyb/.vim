
" let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {'python': ['pyls']}
let g:LanguageClient_diagnosticsDisplay = {
    \ 1: {
        \ "name": "Error",
        \ "texthl": "ALEError",
        \ "signText": "",
        \ "signTexthl": "ALEErrorSign",
    \ },
    \ 2: {
        \ "name": "Warning",
        \ "texthl": "ALEWarning",
        \ "signText": "",
        \ "signTexthl": "ALEWarningSign",
    \ },
    \ 3: {
        \ "name": "Information",
        \ "texthl": "ALEInfo",
        \ "signText": "•",
        \ "signTexthl": "ALEInfoSign",
    \ },
    \ 4: {
        \ "name": "Hint",
        \ "texthl": "ALEInfo",
        \ "signText": "",
        \ "signTexthl": "ALEInfoSign",
    \ }}
