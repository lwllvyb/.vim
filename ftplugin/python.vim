set fdl=4 fdm=indent

set omnifunc=LanguageClient#complete
set completefunc=LanguageClient#complete

set sw=4 ts=4
set isk&

let b:py3 = getline(1) =~ 'python$' ? 0: 1
let b:pyw = expand('%:e') == 'pyw'
let b:ipy = 1

com -buffer Py3Toggle let b:py3 = !b:py3
com -buffer PywToggle let b:pyw = !b:pyw
com -buffer IPyToggle let b:ipy = !b:ipy

nnoremap <buffer><silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <buffer><silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <buffer><silent> <F2> :call LanguageClient_textDocument_rename()<CR>

if exists('g:popup_loaded') && !exists('b:popup_menus')
    let b:popup_menus = {
                \ 'goto': {->pmenu#new('Goto',
                            \ ['f', 'Function', '/\<def\s\+' . "\<c-r>\<c-w>\<cr>" . '(.*):\s*$']
                            \ ).merge(pmenu#common#goto())},
                \ 'util': {->pmenu#new('Util',
                            \ ['p', 'Print', "yiwoprint()\<esc>P"],
                            \ ['b', 'BP', '']
                            \ ).merge(pmenu#util#n())},
                \ 'util-v': {->pmenu#new('Util',
                            \ ['p', 'Print', "yoprint()\<esc>P"]
                            \ ).merge(pmenu#util#v())},
                \ }
endif
