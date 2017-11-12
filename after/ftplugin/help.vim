
setl nolist

nnoremap <buffer><cr> <c-]>

if exists('g:popup_loaded')
    fun! s:get_util()
        if !exists('s:util')
            let s:util = pmenu#new('Util', ['o', 'Show toc', ":call mix#help_toc()\<cr>"])
            call s:util.merge(pmenu#util#n())
        endif
        return s:util
    endf

    let b:popup_menus = {'util': funcref('s:get_util')}
endif
