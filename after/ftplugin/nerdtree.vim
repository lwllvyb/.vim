
" setl signcolumn=yes

nmap <buffer><silent> dd mdy
nmap <buffer> <DEL> md
nmap <buffer> <F2> mm
nmap <buffer> gg P

unmap <buffer> <c-j>
unmap <buffer> <c-k>

if exists('g:popup_loaded')
    let b:popup_menus = {
        \ 'util': 'pmenu#nerdtree#n'
        \ }
endif

" Let the cursor in body of filename {{{
fun! s:set_cursor()
    let n = match(getline('.'), '^\s*\(\[.\{-}\]\)\?\zs')
    if col('.') - 1 < n
        call cursor(line('.'), n+1)
    endif
endf
au CursorMoved <buffer> call <SID>set_cursor()
" }}}
