
" let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {}

if executable('pyls')
    let LanguageClient_serverCommands.python = ['pyls']
endif

if executable('cquery')
    let LanguageClient_serverCommands.cpp = ['cquery', '--language-server']
endif

let g:LanguageClient_changeThrottle = 0.5
let g:LanguageClient_windowLogMessageLevel = 'Error'
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

nnoremap <F2> :call LanguageClient_textDocument_rename()<cr>
nnoremap <expr><F12> has_key(g:LanguageClient_serverCommands, &ft) ? ":call LanguageClient_textDocument_definition()\<cr>": 'gd'
