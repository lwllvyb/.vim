" =============================================================================
" Filename:     plugin/command.vim
" Author:       luzhlon
" Function:     My vim commands
" Last Change:  2017/1/31
" =============================================================================

if filereadable(glob('~/.config/tom.vim'))
    so ~/.config/tom.vim
endif
com! OpenNote tabnew | exe 'lc ' . $MY_NOTES_DIR | NERDTree
com! OpenVimConf tabnew | lc ~/.vim | NERDTree

if has('win32')
    com! EditHosts 
        \e C:\Windows\System32\drivers\etc\hosts | 
        \setl fileformat=dos
else
    com! EditHosts e /etc/hosts
endif
