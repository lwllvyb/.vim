
set sw=4 sts=4 ts=4 fdm=marker

let &fmr=' {{{, }}}'
set mps+=<:>
set iskeyword&

"vnoremap <buffer><silent> <space>x "ty:call execute(@t)<cr>
"nnoremap <buffer><silent> <space>x :call execute(getline(line('.')))<cr>
nnoremap <buffer><silent> <F5> :w<cr>:so %<cr>
nnoremap <buffer> <F9> :breakadd here<cr>
imap <buffer><F5> <esc><F5>

nnoremap <expr><buffer><c-j> (foldlevel('.') ? 'za': 'V}zfzc')
vnoremap <buffer><m-o> yoechom <c-r>" \| call getchar()<esc>
nmap <buffer><m-o> viw<m-o>

if exists('g:popup_loaded')
    if exists('s:goto') | finish | endif

    fun! s:get_goto()
        let s:goto = pmenu#new('Goto',
                \ ['f', 'Function', ":call vmode#goto_define()\<cr>"],
                \ ['v', 'Variable', ":call vmode#search_var('\<c-r>\<c-w>')\<cr>"])
        call s:goto.merge(pmenu#common#goto())
        return s:goto
    endf
    let b:popup_menus = {'goto': funcref('s:get_goto')}
endif
