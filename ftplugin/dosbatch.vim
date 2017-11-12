
fun! s:gen_prog_wrap(path)
    call append(0, '@echo off')
    call setline(2, '%~dp0\' . a:path . ' %*')
endf

com! -buffer -nargs=+ -complete=file GenProgWrap call <sid>gen_prog_wrap(<q-args>)

if exists('g:popup_loaded')
    if !exists('s:popup_menu')
        let s:popup_menu = pmenu#new('Util',
            \ ['w', 'Generate Program Wrap', ":GenProgWrap "])
        call s:popup_menu.merge(popup#get('util'))
    endif
    let b:popup_menus = {'util': s:popup_menu}
endif
