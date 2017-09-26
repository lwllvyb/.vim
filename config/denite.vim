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
        \ 'split': 'vertical',
        \ 'winwidth': '48'
        \ })

    " My commands
    let cmds = {
        \ 'description': 'My commands',
        \ 'command_candidates': [
            \ ['Open cmd.exe', 'call open#cmd()'],
            \ ['Show the runtime path', 'Echo split(&rtp, ",")'],
            \ ['Open powershell', 'call open#powershell()'],
            \ ['Open bash', 'call open#bash()'],
            \ ['Open current directory', 'call open#curdir()']
        \ ]}
    " My files
    let files = {
        \ 'description': 'My files',
        \ 'file_candidates': [
            \ ['Hosts', has('win32') ?
                \ 'C:\Windows\System32\drivers\etc\hosts': '/etc/hosts'],
            \ ['MyVimrc', '~/.config/local.vim']]
        \ }
    " My files
    call denite#custom#var('menu', 'menus', {
        \ 'mycmds': cmds, 'myfiles': files
        \ })
endf

au VimEnter * call <SID>config()

nnoremap <silent><c-p> :DeniteProjectDir file_rec<cr>
nnoremap <silent><c-tab> :Denite buffer<cr>
