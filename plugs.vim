let Plugs = {
    \'easymotion' : 'Lokaltog/vim-easymotion',
    \'xptemplate' : 'drmingdrmer/xptemplate',
    \'tabular'    : 'godlygeek/tabular',
    \'nerdtree'   : 'scrooloose/nerdtree',
    \'surround'   : 'tpope/vim-surround',
    \'hack'       : 'luzhlon/hack.vim',
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
    \'deoplete'   : 'Shougo/deoplete.nvim',
    \'comment'    : 'tpope/vim-commentary',
    \'colors'     : 'gko/vim-coloresque',
    \'tagbar'     : 'majutsushi/tagbar'
\}
let Plugs2Load = [
    \'easymotion',
    \'xptemplate',
    \'tabular',
    \'nerdtree',
    \'surround',
    \'hack',
    \'markdown',
    \'mdpreview',
    \'completor',
    \'emmet',
    \'indent',
    \'jedi',
    \'clang']

for i in Plugs2Load
    call LoadPlugin(Plugs[i], i)
endfo
