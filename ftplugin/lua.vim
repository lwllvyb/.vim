
set isk&

setl cms=--\ %s
nnoremap <buffer> <silent> <F5> :w<cr>:!lua %:p<cr>
vnoremap <buffer><m-o> yoprint()<esc>P

if exists('g:popup_loaded') && !exists('b:popup_menus')
    let b:popup_menus = {
                \ 'util': {->pmenu#new('Util',
                            \ ['x', 'Exec in nvim', ":update|luafile %\<cr>"],
                            \ ).merge(pmenu#util#n())},
                \ }
endif
