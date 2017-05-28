let PlugList = {
    \'easymotion' : 'Lokaltog/vim-easymotion',
    \'xptemplate' : 'drmingdrmer/xptemplate',
    \'tabular'    : 'godlygeek/tabular',
    \'nerdtree'   : 'scrooloose/nerdtree',
    \'surround'   : 'tpope/vim-surround',
    \'mix'        : 'luzhlon/mix.vim',
    \'job'        : 'luzhlon/job.vim',
    \'qrun'       : 'luzhlon/qrun.vim',
    \'popup'      : 'luzhlon/popup.vim',
    \'markdown'   : 'luzhlon/vim-markdown',
    \'mdpreview'  : 'iamcco/markdown-preview.vim',
    \'emmet'      : 'mattn/emmet-vim',
    \'indent'     : 'nathanaelkane/vim-indent-guides',
    \'gtags'      : 'aceofall/gtags.vim',
    \'completor'  : 'maralla/completor.vim',
    \'jedi'       : 'davidhalter/jedi-vim',
    \'clang'      : 'Rip-Rip/clang_complete',
    \'ycm'        : 'Valloric/YouCompleteMe',
    \'lightline'  : 'itchyny/lightline.vim',
    \'devicons'   : 'ryanoasis/vim-devicons',
    \'airline'    : 'vim-airline/vim-airline',
    \'graphviz'   : 'wannesm/wmgraphviz.vim',
    \'denite'     : 'Shougo/denite.nvim',
    \'deoplete'   : 'Shougo/deoplete.nvim',
    \'comment'    : 'tpope/vim-commentary',
    \'colors'     : 'gko/vim-coloresque',
    \'tagbar'     : 'majutsushi/tagbar'
\}

if !exists('Plug2Load')
    let Plug2Load = [
        \'easymotion', 'xptemplate', 'tabular', 'colors',
        \'denite', 'job', 'qrun', 'popup', 'lightline',
        \'nerdtree', 'comment', 'surround', 'mix', 'markdown',
        \'mdpreview', 'graphviz', 'emmet', 'indent', 'jedi']
    if has('nvim')
        let Plug2Load += ['deoplete']
    endif
endif
for i in Plug2Load
    if has_key(PlugList, i)
        call LoadPlugin(PlugList[i], i)
    endif
endfo
