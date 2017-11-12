


if exists('g:popup_loaded')
    if !exists('s:popup_menu')
        let s:popup_menu = pmenu#new('Util',
            \ ['b', 'Base64 Encode', "yGo\<cr><c-r>=ctf#base64#encode(@\")<cr>"],
            \ ['B', 'Base64 Encode', "yGo\<cr><c-r>=ctf#base64#decode(@\")<cr>"],
            \ ['B', 'Base64 Encode', "yGo\<cr><c-r>=ctf#base64#decode(@\")<cr>"],
            \ ['B', 'Base64 Encode', "yGo\<cr><c-r>=ctf#base64#decode(@\")<cr>"],
            \ ['B', 'Base64 Encode', "yGo\<cr><c-r>=ctf#base64#decode(@\")<cr>"],
            \ )
        call s:popup_menu.merge(popup#get('util'))
    endif
    let b:popup_menus = {'util': s:popup_menu}
endif
