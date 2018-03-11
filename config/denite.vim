fun! s:config()
    if executable('pt')
        call denite#custom#var('file_rec', 'command',
            \ ['pt', '--follow', '--nocolor', '--nogroup', '-g:', ''])
    endif

    " Key mapping
    call denite#custom#map('insert', '<c-j>', '<denite:assign_next_text>')
    call denite#custom#map('insert', '<c-k>', '<denite:assign_previous_text>')
    call denite#custom#map('insert', '<c-n>', '<denite:move_to_next_line>')
    call denite#custom#map('insert', '<c-p>', '<denite:move_to_previous_line>')
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
                \ ['LocalConfig', '~/.config/local.vim'],
                \ ['GitConfig', '~/.gitconfig'],
                \ ['Hosts', has('win32') ?
                    \ 'C:\Windows\System32\drivers\etc\hosts': '/etc/hosts'],
                \ ['OniConfig', has('win32') ?
                    \ '$APPDATA\oni\config.js': '~/.oni/config.js']]
        \ }
    \ })

    " call denite#custom#var('outline', 'command', {
    "     \ 'options':
    " \ })
endf

call s:config()
