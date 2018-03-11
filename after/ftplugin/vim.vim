
setl sw=4 sts=4 ts=4 fdm=marker

let &fmr=' {{{, }}}'
setl mps+=<:>
setl iskeyword&

"vnoremap <buffer><silent> <space>x "ty:call execute(@t)<cr>
"nnoremap <buffer><silent> <space>x :call execute(getline(line('.')))<cr>
nnoremap <buffer><silent> <F5> :update<cr>:so %<cr>
imap <buffer><F5> <esc><F5>

nnoremap <expr><buffer><c-j> (foldlevel('.') ? 'za': 'V}zfzc')

if has_key(g:, 'textobj#delimited#default_patterns')
    let b:textobj_delimited_patterns = g:textobj#delimited#default_patterns
endif

if exists('g:popup')
    call popup#reg('util#n', pmenu#new('Util',
        \ ['e!', 'Echo ...', "viwyoechom \<c-r>\" | call getchar()\<esc>"],
        \ ['b:', 'Breakadd', 'breakadd here'],
        \ ['f:', 'Function', 'call vmode#goto_define()'],
        \ ['v!', 'Variable', "call vmode#search_var('\<c-r>\<c-w>')"],
    \ ), &ft)
endif
