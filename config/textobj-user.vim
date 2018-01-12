
call textobj#user#plugin('path', {
    \ 'next_path': {
      \ 'select-a': 'ap', 'select-i': 'ip',
      \ '*select-a-function*': 'textobj#path#select_ap',
      \ '*select-i-function*': 'textobj#path#select_ip',
    \ },
    \ 'prev_path': {
      \ 'select-a': 'aP', 'select-i': 'iP',
      \ '*select-a-function*': 'textobj#path#select_aP',
      \ '*select-i-function*': 'textobj#path#select_iP',
    \ },
\ })

call textobj#user#plugin('url', {
    \ '-': {
      \ 'select-a': 'au', 'select-i': 'iu',
      \ '*select-a-function*': 'textobj#url#select_a',
      \ '*select-i-function*': 'textobj#url#select_i',
    \ },
\ })

call textobj#user#plugin('quote', {
    \ 'quote': {
      \ 'select-a': 'aq', 'select-i': 'iq',
      \ '*select-a-function*': 'textobj#quote#select_a',
      \ '*select-i-function*': 'textobj#quote#select_i',
    \ },
\ })

call textobj#user#plugin('anyblock', {
    \ '-' : {
      \ 'select-a': 'ab', 'select-i': 'ib',
      \ '*select-a-function*': 'textobj#anyblock#a',
      \ '*select-i-function*': 'textobj#anyblock#i',
    \ },
\ })

call textobj#user#plugin('indent', {
    \ '-': {
      \ 'select-a': 'ai', 'select-i': 'ii',
      \ '*select-a-function*': 'textobj#indent#select_a',
      \ '*select-i-function*': 'textobj#indent#select_i',
    \ },
    \ 'same': {
    \   'select-a': 'aI', 'select-i': 'iI',
    \   '*select-a-function*': 'textobj#indent#select_same_a',
    \   '*select-i-function*': 'textobj#indent#select_same_i',
    \ }
\ })

call textobj#user#plugin('postexpr', {
    \ '-': {
      \ 'select-a': 'a,', 'select-i': 'i,',
      \ '*select-a-function*': 'textobj#postexpr#select_a',
      \ '*select-i-function*': 'textobj#postexpr#select_i',
    \ }
\ })

call textobj#user#plugin('syntax', {
    \ '-': {
      \ 'select-a': 'an', 'select-i': 'in',
      \ '*select-a-function*': 'textobj#syntax#select_a',
      \ '*select-i-function*': 'textobj#syntax#select_i',
    \ }
\ })

call textobj#user#plugin('lastpat', {
    \ 'n': {
      \ 'select': ['a/', 'i/'],
      \ '*select-function*': 'textobj#lastpat#n',
    \ },
    \ 'N': {
      \ 'select': ['a?', 'i?'],
      \ '*select-function*': 'textobj#lastpat#N',
    \ },
\ })

call textobj#user#plugin('methodcall', {
  \   '-': {
  \     'select-a': 'ac', 'select-i': 'ic',
  \     '*select-a-function*': 'textobj#methodcall#a',
  \     '*select-i-function*': 'textobj#methodcall#i',
  \   },
  \   'chain': {
  \     'select-a': 'aC', 'select-i': 'iC',
  \     '*select-a-function*': 'textobj#methodcall#chain_a',
  \     '*select-i-function*': 'textobj#methodcall#chain_i',
  \   },
  \ })

call textobj#user#plugin('custom', {
    \ 'space-i': {
      \ 'pattern': '\%(^\|\s*\)\zs\S\+\ze\%(\s\+\|$\)',
      \ 'select': ['i<space>'],
    \ },
    \ 'space-a': {
      \ 'pattern': '\%(^\|\s*\)\S\+\ze\%(\s\+\|$\)',
      \ 'select': ['a<space>'],
    \ },
\ })

silent! onoremap <silent><unique>id :<C-u>call textobj#delimited#i('o')<CR>
silent! xnoremap <silent><unique>id :<C-u>call textobj#delimited#i('v')<CR>
silent! onoremap <silent><unique>ad :<C-u>call textobj#delimited#a('o')<CR>
silent! xnoremap <silent><unique>ad :<C-u>call textobj#delimited#a('v')<CR>
