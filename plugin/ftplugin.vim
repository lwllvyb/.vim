" =============================================================================
" Filename:    plugin\ftplugin.vim
" Author:      luzhlon
" Date:        2017-10-10
" Description: 首次加载buffer时加载ftplugin插件
" =============================================================================

fun! MyLoadFTPlugin(...)
    let force = a:0 ? a:1 : 0
    if !exists('b:loaded_ftplugin') || force
        let b:loaded_ftplugin = 1
        let s = expand('<amatch>')
        if s != ''
            for name in split(s, '\.')
                exe 'runtime!' 'autoload/ftplugin/' . name . '.vim'
            endfor
        endif
    endif
endf

au FileType * call MyLoadFTPlugin()
