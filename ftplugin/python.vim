
setl omnifunc=LanguageClient#complete
setl completefunc=LanguageClient#complete

setl fdl=4 fdm=indent sw=4 ts=4 isk&

let b:py3 = getline(1) =~ 'python$' ? 0: 1
let b:pyw = expand('%:e') == 'pyw'
let b:ipy = 1

nnoremap <buffer><silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <buffer><silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <buffer><silent> <F2> :call LanguageClient_textDocument_rename()<CR>

if !exists('g:popup') || len(popup#menus(&ft))
    finish
endif

call popup#reg('common#goto', pmenu#new('Goto',
    \ ['f', 'Function', '/\<def\s\+' . "\<c-r>\<c-w>\<cr>" . '(.*):\s*$']
\ ))

call popup#reg('util#n', pmenu#new('Util',
    \ ['3:', 'Py3Toggle', 'let b:py3 = !b:py3'],
    \ ['w:', 'PywToggle', 'let b:pyw = !b:pyw'],
    \ ['i:', 'IPyToggle', 'let b:ipy = !b:ipy'],
    \ ['p', 'Print', "yiwoprint()\<esc>P"],
    \ ['b', 'BP', ''],
\ )

call popup#reg('util#v', pmenu#new('Util',
    \ ['p', 'Print', "yoprint()\<esc>P"]
\ ))
