scripte utf-8
let sub = [['/', '// && \\', [
              \['x', '\ -> \\', ':s/\\/\\\\/g'."\<cr>"],
              \['c', '\\ -> \', ':s/\\\\/\\/g'."\<cr>"],
              \['/', '/ -> \' , ':s/\//\\/g'."\<cr>"],
              \['\', '\ -> /' , ':s/\\/\//g'."\<cr>"]]],
          \['m', 'Comment', 'ss/\/\/\s*\(.*\)/\/* \1 *\/' . "\<cr>"],
          \['c', 'Full-width Char', [
              \['c', 'Colon', ":s:/：/:/g\<cr>"],
              \['b', 'Breakets', ":s:/（\\(.\\{-}\\)）/\1/g\<cr>"]]],
          \['x', 'Count', ":s/\<c-r>//\\=repeat('-', len(submatch(0)))"],
          \['s', 'Spaces', [
              \["\t", 'Tab -> Space', ":s/\t/\\=repeat(' ',\&ts)/g\<cr>"] ,
              \["\r", 'Kill emptyline', ":g/^$/del\<cr>"],
              \['s', 'Kill end-space', printf(':s/\s*%s*$%s',"\<c-v>\<c-m>" , "\<cr>")]]],
          \[';', 'Add ;' , ':g! /\(\(\/\/.\{-}\)\|[{};]\|\(else\)\)$/norm A;'."\<cr>"]]

let align = [['=', 'By "="', ":Tabularize /=\<cr>"],
           \ [':', 'By ":"', ":Tabularize /:\<cr>"],
           \ [',', 'By ","', ":Tabularize /,\<cr>"],
           \ ['e', 'By ...', ":Tabularize /"]]
let open = []
let util = [
        \[' ', 'No hilight', ":noh\<cr>"],
        \['.', 'Ex-command', '@:'],
        \['a', 'Alignment', align],
        \['s', 'Replacement', sub],
        \['o', 'Open ...', open]]
if has('win32')
    call extend(open, [
        \['c', 'CMD.EXE', ":sil !start cmd.exe\<cr>"],
        \['b', 'BASH.EXE', ":sil !start bash\<cr>"],
        \['p', 'PowerShell', ":sil !start powershell.exe\<cr>"],
        \['o', 'Reopen File' , ":!start gvim \"%:p\"\<cr>:conf qa\<cr>"],
        \['r', 'Reopen *Vim', ":call waitstart#(getpid(), v:progpath) | conf qa\<cr>"],
        \['d', 'Current DIR', ":sil !start explorer \"%:p:h\"\<cr>"]])
elseif executable('cmd.exe')    " WSL
    call extend(open, [
        \['c', 'CMD.EXE', ":!cmd.exe /c start cmd\<cr>"],
        \['b', 'BASH.EXE', ":!cmd.exe /c start bash\<cr>"],
        \['p', 'PowerShell', ":!cmd.exe /c start powershell.exe\<cr>"],
        \['d', 'Current DIR', ":!cmd.exe /c start explorer \"%:p:h\"\<cr>"]])
else
    call extend(open, [
        \['t', 'Terminal', ":xdg-open gnome-terminal\<cr>"],
        \['b', 'Bash', ":sil !start bash\<cr>"]])
endif
call popup#add('util', 'Util', util)
call popup#add('util-v', 'Util',
    \['x', 'Execute VimL' , "y:exe @\"\<cr>"],
    \['a', 'Alignment' , align],
    \['s', 'Replacement' , sub])

nnoremap <expr><space>  Popup('util')
vnoremap <expr><space>  Popup('util-v')
