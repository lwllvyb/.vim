
" setl signcolumn=yes

nmap <buffer><silent> dd mdy
nmap <buffer> <DEL> md
nmap <buffer> <F2> mm
nmap <buffer> gg P

unmap <buffer> <c-j>
unmap <buffer> <c-k>

fun! s:open()
    let curNode = g:NERDTreeFileNode.GetSelected()
    call open#(curNode.path.str())
    return ''
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

if exists('g:popup_loaded')
    call popup#addl('util', 'Util',
        \ ['e', 'EXPLORER', funcref('s:open')],
        \ ['c', 'Copy', funcref('s:copy')],
        \ ['x', 'Cut', funcref('s:cut')],
        \ ['p', 'Paste', funcref('s:paste')],
        \ '--------------------------------')
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
