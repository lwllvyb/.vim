
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

fun! s:move2filewin()
    winc p
    let nr = winnr()
    while 1
        let buf = winbufnr(0)
        if empty(getbufvar(buf, '&bt'))
            return 1
        endif
        winc w
        if winnr() == nr | break | endif
    endw
endf

fun! s:search_file()
    let cur_node = g:NERDTreeFileNode.GetSelected()
    let cur_path = cur_node.path.getDir().str()
    let cur_path = fnamemodify(cur_path, ':.')
    if !s:move2filewin()
        belowright winc v
        ene
    endif
    exe 'Denite file_rec:' . cur_path
endf

nnoremap <buffer><silent><c-p> :call <sid>search_file()<cr>

" Let the cursor in body of filename {{{
fun! s:set_cursor()
    let n = match(getline('.'), '^\s*\(\[.\{-}\]\)\?\zs')
    if col('.') - 1 < n
        call cursor(line('.'), n+1)
    endif
endf
au CursorMoved <buffer> call <SID>set_cursor()
" }}}
