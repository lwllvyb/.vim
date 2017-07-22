com! -nargs=+ DeinAdd call dein#add(<args>)
com! -nargs=* DeinInstall call dein#install(<args>)
com! -nargs=* DeinReinstall call dein#reinstall(<args>)
com! -nargs=* DeinUpdate call dein#update(<args>)
com! -nargs=+ DeinConfig call dein#config(<args>)
com! -nargs=+ DeinLocal call dein#local(<args>)
com! DeinStateClean call dein#clear_state()

let s:confdir = expand('<sfile>:h') . '/config/'
fun! ConfigHook()
    for p in keys(dein#get())
        let f = s:confdir . p
        let f = substitute(f, '\([-\.]n\?vim\)\?$', '.vim', '')
        if filereadable(f)
            call dein#set_hook(p, 'hook_source', 'so ' . f)
        elseif isdirectory(f)
            let fs = glob(f . '/*.vim', 0, 1)
            fun! T() closure
                for f in fs|exe 'so' f|endfo
            endf
            call dein#set_hook(p, 'hook_source', funcref('T'))
        endif
    endfo
endf

if dein#load_state(g:dein_dir)
    let LOG.load_state = 1
    call dein#begin(g:dein_dir)

    DeinLocal '~/vimplugs'

    DeinConfig 'vim-markdown', {'on_ft': 'markdown'}
    DeinConfig 'xmake.vim', {'depends': ['job.vim', 'qrun.vim']}

    DeinAdd 'Lokaltog/vim-easymotion', {'name': 'easymotion'}
    DeinAdd 'drmingdrmer/xptemplate'
    DeinAdd 'godlygeek/tabular'
    DeinAdd 'scrooloose/nerdtree', {'name': 'nerdtree'}
    DeinAdd 'tpope/vim-surround'
    DeinAdd 'iamcco/mathjax-support-for-mkdp'
    DeinAdd 'iamcco/markdown-preview.vim', {'on_ft': 'markdown'}
    DeinAdd 'mattn/emmet-vim', {'name': 'emmet', 'on_ft': 'html'}
    DeinAdd 'davidhalter/jedi-vim', {'on_ft': 'python'}
    DeinAdd 'Rip-Rip/clang_complete', {'on_ft': ['c', 'cpp']}
    DeinAdd 'itchyny/lightline.vim'
    DeinAdd 'terryma/vim-expand-region', {'name': 'expand-region'}
    " DeinAdd 'nathanaelkane/vim-indent-guides'
    " DeinAdd 'Valloric/YouCompleteMe'
    " DeinAdd 'ryanoasis/vim-devicons'
    " DeinAdd 'vim-airline/vim-airline'
    " DeinAdd 'maralla/completor.vim'
    DeinAdd 'wannesm/wmgraphviz.vim', {'on_ft': 'dot'}
    DeinAdd 'Shougo/denite.nvim'
    DeinAdd 'Shougo/deoplete.nvim', {'if': 'has("nvim")'}
    DeinAdd 'tpope/vim-commentary', {'name': 'commentary'}
    DeinAdd 'gko/vim-coloresque', {'name': 'coloresque', 'on_ft': ['css', 'html', 'markdown']}
    DeinAdd 'morhetz/gruvbox'
    DeinAdd 'majutsushi/tagbar'

    call ConfigHook()
    call dein#end()
    call dein#call_hook('source')
    " call dein#save_state()
endif

" autocmd VimEnter * call dein#call_hook('post_source')
