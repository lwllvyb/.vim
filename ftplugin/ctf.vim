
if !exists('g:popup') || len(popup#menus(&ft))
    finish
endif

call popup#reg('util#n', pmenu#new('Util',
    \ ['b', 'Base64 Encode', "yGo\<cr><c-r>=ctf#base64#encode(@\")<cr>"],
    \ ['B', 'Base64 Encode', "yGo\<cr><c-r>=ctf#base64#decode(@\")<cr>"],
    \ ['B', 'Base64 Encode', "yGo\<cr><c-r>=ctf#base64#decode(@\")<cr>"],
    \ ['B', 'Base64 Encode', "yGo\<cr><c-r>=ctf#base64#decode(@\")<cr>"],
    \ ['B', 'Base64 Encode', "yGo\<cr><c-r>=ctf#base64#decode(@\")<cr>"],
\ ))
