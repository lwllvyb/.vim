
if !exists('g:help#pattern')
    let g:help#pattern = {}
endif

if !has_key(g:help#pattern, 'lua')
    let g:help#pattern.lua = '^*\s\+`%s'
endif

fun! s:finddir(subdir)
    for dir in split(&rtp, ',')
        let thedir = dir . '/' . a:subdir
        if isdirectory(thedir)
            return thedir
        endif
    endfo
endf

fun! help#keyword()
    let orgin = &iskeyword
    let &isk = get(b:, 'help_iskeyword', &iskeyword)
    let keyword = expand('<cword>')
    let &isk = orgin
    return keyword
endf

fun! help#(...)
    let keyword = a:0 ? a:1 : help#keyword()

    let dir = s:finddir('doc/' . &ft)
    if empty(dir)
        echo 'No help for filetype:' &ft
        return
    endif
    let pattern = get(g:help#pattern, &ft)
    let pattern = empty(pattern) ?  keyword :
                \ printf(pattern, keyword)
    split
    try
        exe 'vim /' . pattern . '/' dir . '/**'
        set bh=hide
    catch /E480/
        close
        echo 'No help for keyword:' keyword
    endt
endf

fun! help#map_K()
    if !has_key(g:help#pattern, &ft)
        return 'K'
    endif
    return mode() == 'v' ?
                \ "y:call help#(@\")\<cr>" :
                \ ":call help#()\<cr>"
endf

com! -nargs=* Help call help#(<q-args>)
