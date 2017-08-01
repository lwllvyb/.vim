
call popup#add('else', 'ELSE',
        \['l', 'Youdao Translate', "yiw:sil YouDao \<c-r>\"\<cr>"],
        \['b', 'Baidu Search', "yiw:sil Baidu \<c-r>\"\<cr>"],
        \['o', 'Open link', 'gx'],
        \['c', 'Copy filename', ":let @+ = expand('%')\<cr>"])

call popup#add('else-v', 'ELSE',
        \['l', 'Youdao Translate', "y:sil YouDao \<c-r>\"\<cr>"],
        \['b', 'Baidu Search', "y:sil Baidu \<c-r>\"\<cr>"])

nnoremap <expr><m-u>  Popup('else')
vnoremap <expr><m-u>  Popup('else-v')
