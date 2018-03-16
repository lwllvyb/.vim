
" setl signcolumn=yes

nmap <buffer><silent> dd mdy
nmap <buffer> <DEL> md
nmap <buffer> <F2> mm
nmap <buffer> gg P

unmap <buffer> <c-j>
unmap <buffer> <c-k>

nnoremap <buffer><silent><c-p> :call <sid>search_file()<cr>

fun! s:open()
    let curNode = g:NERDTreeFileNode.GetSelected()
    echom curNode.path.str()
    call open#(curNode.path.str())
    return ''
endf

fun! s:search_text()
    let cur_node = g:NERDTreeFileNode.GetSelected()
    let cur_path = cur_node.path.getDir().str()
    return printf("\<c-w>p:vim /%s/ %s/*", input('Pattern: '), cur_path)
endf

fun! s:search_file()
    let cur_node = g:NERDTreeFileNode.GetSelected()
    let cur_path = cur_node.path.getDir().str()
    let cur_path = fnamemodify(cur_path, ':.')
    return "\<c-w>p:Denite file_rec:" . cur_path . "\<cr>"
endf

let s:node2mod = ''
let s:ismove = 0

" Store a node to copy {{{
fun! s:copy()
    let s:node2mod = g:NERDTreeFileNode.GetSelected()
    let s:ismove = 0
    return ''
endf
" }}}

" Store a node to move {{{
fun! s:cut()
    let s:node2mod = g:NERDTreeFileNode.GetSelected()
    let s:ismove = 1
    return ''
endf
" }}}

" Copy or move {{{
fun! s:paste()
    if empty(s:node2mod)
        echo 'No file in the clipboard.'
    else
        let node = g:NERDTreeFileNode.GetSelected()
        let newNodePath = node.path.getDir().str() . '/' . s:node2mod.path.pathSegments[-1]
        let confirmed = 1
        if s:node2mod.path.copyingWillOverwrite(newNodePath)
            call nerdtree#echo("Warning: copying may overwrite files! Continue? (yN)")
            let choice = nr2char(getchar())
            let confirmed = choice ==# 'y'
        endif
        if confirmed
            try
                if s:ismove
                    call s:node2mod.rename(newNodePath)
                    call NERDTreeRender()
                    call s:node2mod.putCursorHere(1, 0)
                else
                    let newNode = s:node2mod.copy(newNodePath)
                    if empty(newNode)
                        call b:NERDTree.root.refresh()
                        call b:NERDTree.render()
                    else
                        call NERDTreeRender()
                        call newNode.putCursorHere(0, 0)
                    endif
                endif
            catch /^NERDTree/
                call nerdtree#echoWarning("Could not copy node")
            catch
            endtry
        endif
    endif
    return ''
endf
" }}}

" Move cursor to a file window {{{
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
" }}}

" {{{
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
" }}}

if exists('&winhl')
    setl winhl=Normal:NormalDeep,CursorLine:CursorLineDeep
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

if exists('g:popup')
    call popup#reg('util#n', pmenu#new('NERDTree',
        \ ['o!', 'Open', funcref('s:open')],
        \ ['s!', 'Search Text', funcref('s:search_text')],
        \ ['f!', 'Search File', funcref('s:search_file')],
        \ ['c!', 'Copy', funcref('s:copy')],
        \ ['x!', 'Cut', funcref('s:cut')],
        \ ['p!', 'Paste', funcref('s:paste')],
    \ ), &ft)
endif

if !exists('s:checkleave')
    fun! s:checkleave()
        if getbufvar('#', '&ft') == 'nerdtree' && getbufvar('#', '&bt') == 'nofile'
            let nr = bufnr('%')
            if empty(getbufvar(nr, '&bt'))
                silent! b! #
                call s:move2filewin()
                exe nr 'b!'
            endif
        endif
    endf
    au BufEnter * call <sid>checkleave()
endif
