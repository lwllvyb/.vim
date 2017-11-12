
fun! s:init()
    let s:goto = pmenu#new('Goto',
            \ ['n', 'Next Header', "\<Plug>Markdown_MoveToNextHeader"],
            \ ['p', 'Prev Header', "\<Plug>Markdown_MoveToPreviousHeader"],
            \ ['.', 'Current Header', "\<Plug>Markdown_MoveToCurHeader"],
            \ ['a', 'Parent Header', "\<Plug>Markdown_MoveToParentHeader"],
            \ ['j', 'Next Sibling', "\<Plug>Markdown_MoveToNextSiblingHeader"],
            \ ['k', 'Prev Sibling', "\<Plug>Markdown_MoveToPreviousSiblingHeader"]
            \ )
    call s:goto.merge(pmenu#common#goto())

    let q = ['q', 'Quote', function('mdm#quote')]
    let b = ['b', 'Bold', function('mdm#bold')]
    let c = ['c', 'Code', function('mdm#code')]
    let l = ['l', 'Smart List', ":call mdm#SmartList()\<cr>"]
    let H = ['H', 'Smart Header', ":call mdm#SmartHeader()\<cr>"]
    let O = ['O', 'Orderd List', ":call mdm#OrderedList()\<cr>"]
    let s:util = pmenu#new('Util',
        \ q, b, c, l, H, O,
        \ ['o', 'Toc' , ":Toc\<cr>"],
        \ [',', 'Task', ":call mdplus#togtask()\<cr>"],
        \ ['f', 'Anchor', "yiw/<span id=\"\<c-r>\"\">"])
    call s:util.merge(pmenu#util#n())

    let s:util_v = pmenu#new('Util', q, b, c, l, H, O)
    call s:util_v.merge(pmenu#util#v())

    let s:insert = pmenu#new('Insert',
        \ ['b', 'Bold', "****\<left>\<left>"],
        \ ['i', 'Italic', "**\<left>"],
        \ ['k', 'Task', "* []\<left>"],
        \ ['/', 'Comment', "<!---->\<esc>2h"],
        \ ['l', 'Link', "[]()\<left>"],
        \ ['a', 'Anchor', "<span id=\"\">\<esc>2h"]
        \ )
endf

call s:init()

fun! pmenu#markdown#goto()
    return s:goto
endf

fun! pmenu#markdown#util()
    return s:util
endf

fun! pmenu#markdown#util_v()
    return s:util_v
endf
