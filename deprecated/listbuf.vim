" =============================================================================
" Filename:     plugin/listbuf.vim
" Author:       luzhlon
" Function:     列出buffer的名称，用户选择切换
" Last Change:  2017/3/8
" =============================================================================

fun! s:onEnter()
    set nohls
    let line = getline('.')
    call s:close()
    if bufexists(line)
        exe 'b!' line
    endif
endf
" 显示buffer列表
fun! s:show()
    bot vs|vert res 30
    if exists('s:list_nr') && bufexists(s:list_nr)
        exe s:list_nr.'b'
        setl modifiable
        norm! ggVG"_d
    else            " 不存在已有的buffer list，新建一个
        ene! | let s:list_nr = bufnr('%')
        setl nowrap nolist sw=3 nonu bt=nofile bh=hide nobl
        com! -buffer Enter call <SID>onEnter()
        map <buffer><cr> :Enter<cr>
        cmap <buffer><cr> <cr><cr>
        cmap <buffer><tab> .\{-}
        " syn match Underlined /^\w/
        " syn match Boolean /\%>4c.*/
    endif
    setl modifiable
    2               " 光标挪到第2行:第一个文件的位置
    let s:wnr = winnr()
endf
" 关闭buffer list
fun! s:close()
    winc p
    exe s:wnr . 'winc c'
endf

fun! ListBuffer()
    let bs = getbufinfo({'buflisted':1})

    call s:show()
    for d in bs
        let n = d.bufnr
        if !empty(getbufvar(n, '&bt'))
            continue
        endif
        call append('$', bufname(n))
    endfo
    setl nomodifiable
    redraw!
    let i = nr2char(getchar())
    if i == "\<esc>"
        call s:close()
    elseif i == "\<m-.>"
        call s:close()
        b! #
    elseif i == "\<cr>"
        call feedkeys("\<cr>")
    else
        call feedkeys('/' . i)
    endif
endf
