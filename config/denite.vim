fun! s:config()
    if executable('pt')
        call denite#custom#var('file_rec', 'command',
            \ ['pt', '--follow', '--nocolor', '--nogroup', '-g:', ''])
    endif
    call denite#custom#map('insert', '<c-j>',
        \ '<denite:move_to_next_line>', 'noremap')
    call denite#custom#map('insert', '<c-k>',
        \ '<denite:move_to_previous_line>', 'noremap')
    call denite#custom#map('insert', '<C-a>', '<Home>')
    call denite#custom#map('insert', '<C-e>', '<End>')
    call denite#custom#map('insert', '<C-f>', '<Right>')
    call denite#custom#map('insert', '<C-b>', '<Left>')
endf

au VimEnter * call <SID>config()

nnoremap <c-p> :Denite buffer file_rec<cr>
