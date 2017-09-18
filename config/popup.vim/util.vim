scripte utf-8
let sub = [['/', '// && \\', [
              \['x', '\ -> \\', ':s/\\/\\\\/g'."\<cr>"],
              \['c', '\\ -> \', ':s/\\\\/\\/g'."\<cr>"],
              \['/', '/ -> \' , ':s/\//\\/g'."\<cr>"],
              \['\', '\ -> /' , ':s/\\/\//g'."\<cr>"]]],
          \['m', 'Comment', ':s/\/\/\s*\(.*\)/\/* \1 *\/' . "\<cr>"],
          \['c', 'Full-width Char', [
              \['c', 'Colon', ":s:/：/:/g\<cr>"],
              \['b', 'Breakets', ":s:/（\\(.\\{-}\\)）/\1/g\<cr>"]]],
          \['x', 'Count', ":s/\<c-r>//\\=repeat('-', len(submatch(0)))"],
          \['s', 'Spaces', [
              \["\t", 'Tab -> Space', ":s/\t/\\=repeat(' ',\&ts)/g\<cr>"] ,
              \["\r", 'Kill emptyline', ":g/^$/del\<cr>"],
              \['s', 'Kill end-space', printf(':s/\s*%s*$%s',"\<c-v>\<c-m>" , "\<cr>")]]],
          \[';', 'Add ;' , ':g! /\(\(\/\/.\{-}\)\|[{};]\|\(else\)\)$/norm A;'."\<cr>"]]

let sub = ['s', 'Replacement' , ":Denite menu:mysubs\<cr>"]
call popup#add('util', 'Util', 
    \ [' ', 'No hilight', ":noh\<cr>"],
    \ ['.', 'Ex-command', '@:'], sub,
    \ ['o', 'Open ...', ":Denite menu:mycmds\<cr>"])
call popup#add('util-v', 'Util',
    \ ['x', 'Execute VimL' , "y:exe @\"\<cr>"], sub)

nnoremap <expr><space>  Popup('util')
vnoremap <expr><space>  Popup('util-v')
