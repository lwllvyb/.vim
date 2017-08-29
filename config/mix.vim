
inoremap <expr><tab> (pumvisible()?"\<c-n>":tab#key('tab'))
inoremap <expr><s-tab> (pumvisible()?"\<c-p>":tab#key('stab'))
inoremap <expr><cr> tab#key('cr')
inoremap <expr><s-cr> tab#key('scr')
