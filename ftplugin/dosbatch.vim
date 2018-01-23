
inoremap <buffer><silent><m-cr> <esc>yyo<c-r>=iconv(system(@@),'gbk','utf8')<cr>

fun! s:gen_prog_wrap(path)
    call append(0, '@echo off')
    call setline(2, '%~dp0\' . a:path . ' %*')
endf

com! -buffer -nargs=+ -complete=file GenProgWrap call <sid>gen_prog_wrap(<q-args>)

if !exists('g:popup') || len(popup#menus(&ft))
    finish
endif

call popup#reg('util#n', pmenu#new('Util',
    \ ['w', 'Generate Program Wrap', ":GenProgWrap "]
\ ))
