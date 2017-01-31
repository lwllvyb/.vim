" =============================================================================
" Filename:     plugin/command.vim
" Author:       luzhlon
" Function:     Some useful commands
" Last Change:  2017/1/14
" =============================================================================

com! OpenNote tabnew | lc ~/notebook | NERDTree
com! OpenVimConf tabnew | lc ~/.vim | NERDTree
"change current directory
com! Locate if &buftype == ''|lc %:p:h |endif
com! Scratch ene|setl buftype=nofile|setl noswapfile|setl bufhidden=hide

com! YouDao        call netrw#BrowseX('http://www.youdao.com/w/eng/'.expand('<cword>').'/#keyfrom=dict2.index', netrw#CheckIfRemote())

"增加字体大小
fun! s:addFontSize(n)
    let &gfn =
        \substitute(&gfn, '\d\+', '\=submatch(0)+' . a:n, '')
    let &gfw =
        \substitute(&gfw, '\d\+', '\=submatch(0)+' . a:n, '')
endf
com! FontUp   call <SID>addFontSize(1)
com! FontDown call <SID>addFontSize(-1)
