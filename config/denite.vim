fun! s:config()
    if executable('pt')
        call denite#custom#var('file_rec', 'command',
            \ ['pt', '--follow', '--nocolor', '--nogroup', '-g:', ''])
    endif
    " Key mapping
    call denite#custom#map('insert', '<c-j>',
        \ '<denite:move_to_next_line>', 'noremap')
    call denite#custom#map('insert', '<c-k>',
        \ '<denite:move_to_previous_line>', 'noremap')
    call denite#custom#map('insert', '<c-a>', '<Home>')
    call denite#custom#map('insert', '<c-e>', '<End>')
    call denite#custom#map('insert', '<c-f>', '<Right>')
    call denite#custom#map('insert', '<c-b>', '<Left>')
    call denite#custom#map('insert', '<c-\>', '<denite:do_action:vsplit>')

    " Default options
    call denite#custom#option('_', {
        \ 'prompt': '>',
        \ 'split': 'horizontal', 'direction': 'aboveleft',
        \ 'winwidth': '48', 'winheight': 8
        \ })

    " My files
    call denite#custom#var('menu', 'menus', {
        \ 'myfiles': {
            \ 'description': 'My files',
            \ 'file_candidates': [
                \ ['Hosts', has('win32') ?
                    \ 'C:\Windows\System32\drivers\etc\hosts': '/etc/hosts'],
                \ ['MyVimrc', '~/.config/envs.vim/init.vim']]
        \ }
    \ })
endf

call s:config()
