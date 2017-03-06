" =============================================================================
" Filename:     plugin/command.vim
" Author:       luzhlon
" Function:     My vim commands
" Last Change:  2017/1/31
" =============================================================================

if filereadable(glob('~/.config/tom.vim'))
    so ~/.config/tom.vim
endif
com! OpenVimConf tabnew | lc ~/.vim | NERDTree

if has('win32')
    com! Ps vs Scratch|r! tasklist
    com! EditHosts 
        \e C:\Windows\System32\drivers\etc\hosts | 
        \setl fileformat=dos
else
    com! Ps vs Scratch|r! ps aux
    com! EditHosts e /etc/hosts
endif

