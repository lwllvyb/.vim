
if has('win32')
    com! EditHosts e ++ff=dos C:\Windows\System32\drivers\etc\hosts
else
    com! EditHosts e /etc/hosts
endif

let comment = ['/', 'Comment' , ":Commentary\<cr>"]
call popup#add('edit', 'Edit',
    \['e', 'File ...', [
         \['v', 'VIMRC', ":e $MYVIMRC\<cr>"],
         \['h', 'HOST', "EditHosts\<cr>"]]],
    \['l', 'Line-format', [
         \['d', 'DOS', ":set ff=dos\<cr>"],
         \['u', 'UNIX', ":set ff=unix\<cr>"],
         \['m', 'MAC', ":set ff=mac\<cr>"]]],
    \['f', 'Fold-state' , [
         \['g', 'Toggle', 'za'],
         \['r', 'Toggle -r', 'zA'],
         \['m', 'Fold all', 'zM'],
         \['a', 'Unfold all', 'zR']]],
     \['h', 'HEX EDIT', [
        \['b', 'Start' , ":set bin|%!xxd\<cr>"],
        \['e', 'End' , ":%!xxd -r\<cr>"]]],
    \'---------------------',
    \['p', 'Paste' , "\"+p"],
    \['a', 'Select all' , "ggVG"], comment)

call popup#add('edit-v', 'Edit',
    \['c', 'Copy' , "\"+y"],
    \['t', 'Cut' , "\"+d"],
    \['p', 'Paste' , "\"+p"],
    \'---------------------',
    \['r', 'Replace' , 'y:%s/\V\<'."\<c-r>".'"\>/'],
    \['f', 'Find' , 'y/\V'."\<c-r>\""],
    \['w', 'Find' , 'y/\V\<'."\<c-r>".'"\>'],
    \'---------------------',
    \['f', 'Fold' , 'zf'], comment)

call popup#add('edit-i', 'Edit',
    \['c', 'Copy a line', "\<esc>yypA"],
    \['p', 'Paste', "\<c-o>:set paste\<cr>\<c-r>+\<c-o>:set paste!\<cr>"])

nmap <expr><m-e> Popup('edit')
vmap <expr><m-e> Popup('edit-v')
imap <expr><m-e> Popup('edit-i')
