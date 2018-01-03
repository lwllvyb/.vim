" =============================================================================
" Filename:    plugs.vim
" Author:      luzhlon
" Date:        2017-08-29
" Description: load plugins and configs
" =============================================================================

" Check init {{{
let s:dein_rtp = expand('<sfile>:h') . '/dein.vim'
if !isdirectory(s:dein_rtp)
    fun! CheckRequire()
        let errs = []
        if !executable('git')
            call add(errs, 'Please install git')
        endif
        if !has('python3')
            call add(errs, 'Please install python3.x')
        endif
        " echo the errors
        for err in errs | echom err | endfo
        return !len(errs)
    endf

    if CheckRequire()
        echom 'Please do `git submodule init` to install dein.vim'
    endif
    finish
endif

let &rtp .= ',' . s:dein_rtp
" }}}

" Define some commands for dein {{{
com! -nargs=* DeinInstall call dein#install(<f-args>)
com! -nargs=* DeinReinstall call dein#reinstall(<f-args>)
com! -nargs=* DeinUpdate call dein#update(<f-args>)
com! -nargs=+ DeinSource call dein#source(<f-args>)
com! DeinCheckInstall call dein#check_install()
com! DeinClearState call dein#clear_state()
com! DeinRecache call dein#recache_runtimepath()
" }}}

" Config the plugins {{{
let s:confdir = expand('<sfile>:h') . '/config/'
fun! s:config_hook()
    for [k, v] in items(dein#get())
        let f = s:confdir . v['normalized_name'] . '.vim'
        if filereadable(f)
            call dein#set_hook(k, 'hook_source', 'so ' . f)
        " elseif isdirectory(f)
        "     let fs = glob(f . '/*.vim', 0, 1)
        "     fun! T() closure
        "         for f in fs|exe 'so' f|endfo
        "     endf
        "     call dein#set_hook(k, 'hook_source', funcref('T'))
        endif
    endfo
endf
" }}}

let s:path = expand('<sfile>:p:h')
if !exists('g:dein#cache_directory')
    let g:dein#cache_directory = s:path . '/.dein'
endif

" {{{ load the plugins
if dein#load_state(g:dein#cache_directory)
    call dein#begin(g:dein#cache_directory)

    let my_plug_path = s:path . '/myplugs'
    call dein#local(my_plug_path)

    let on_markdown = {'on_ft': 'markdown'}
    let on_html = {'on_ft': 'html'}

    call dein#config('xmake.vim', {'depends': ['job.vim', 'qrun.vim']})
    call dein#config('vim-markdown', on_markdown)
    call dein#config('mdm.vim', on_markdown)
    call dein#config('idc.vim', {'on_ft': 'idc'})

    call dein#add('Shougo/dein.vim', {'rtp': s:dein_rtp})
" ------------------ Utility -------------------- {{{
    call dein#add('Lokaltog/vim-easymotion', {
                \ 'on_map': {'nv': '<Plug>(easymotion-'}
                \ })
    call dein#add('terryma/vim-expand-region', {
                \ 'on_map': {'nv': '<Plug>(expand_region'}
                \ })
    call dein#add('Shougo/denite.nvim', {'on_cmd': 'Denite*'})
    call dein#add('Shougo/echodoc.vim')
    call dein#add('Shougo/neopairs.vim')
    call dein#add('Shougo/context_filetype.vim')
    call dein#add('SirVer/ultisnips')
    call dein#add('honza/vim-snippets')
    call dein#add('tpope/vim-commentary', {'on_cmd': 'Commentary*'})
    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-repeat')
    " git plugins
    call dein#add('lambdalisue/gina.vim', {'on_cmd': 'Gina*'})
    " call dein#add('airblade/vim-gitgutter', {'on_cmd': 'Git*'})
    " call dein#add('tpope/vim-fugitive')

    " format plugins
    call dein#add('sbdchd/neoformat', {'on_cmd': 'Neoformat*'})
    " call dein#add('Chiel92/vim-autoformat', {'on_cmd': 'Autoformat*'})

    call dein#add('godlygeek/tabular', {'on_cmd': 'Tabularize*)'})
    call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTree*'})
    call dein#add('majutsushi/tagbar', {'on_cmd': 'Tagbar*'})
    call dein#add('libclang-vim/libclang-vim')
    call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')
    call dein#add('RIscRIpt/vim-fasm-syntax')
    call dein#add('MattesGroeger/vim-bookmarks', {'on_cmd': 'Bookmark*'})
    " call dein#add('neomake/neomake')
    call dein#add('vim-voom/VOoM', {'on_cmd': 'Voom*'})
    call dein#add('metakirby5/codi.vim', {'on_cmd': 'Codi*'})
    call dein#add('vim-scripts/csv.vim', {'on_ft': 'csv'})
    call dein#add('KabbAmine/zeavim.vim')
" }}}
" ------------------ textobjs -------------------- {{{
    call dein#add('vim-scripts/argtextobj.vim')
    call dein#add('kana/vim-textobj-user')
    call dein#add('kana/vim-textobj-indent')
    call dein#add('kana/vim-textobj-function')
    call dein#add('libclang-vim/vim-textobj-clang', {'depends': 'libclang-vim'})
    call dein#add('glts/vim-textobj-comment')
    call dein#add('todesking/vim-textobj-methodcall')
    call dein#add('rhysd/vim-textobj-anyblock')
    call dein#add('adriaanzon/vim-textobj-matchit')
    call dein#add('syngan/vim-textobj-postexpr')
" }}}
" ------------------ Web ------------------------- {{{
    call dein#add('mattn/emmet-vim', on_html)
    call dein#add('othree/html5.vim', on_html)
    call dein#add('othree/xml.vim')
" }}}
" ------------------ Markdown/Writing ------------------- {{{
    call dein#add('dhruvasagar/vim-table-mode', on_markdown)
    call dein#add('junegunn/goyo.vim', {'on_cmd': 'Goyo'})
    call dein#add('iamcco/mathjax-support-for-mkdp', on_markdown)
    call dein#add('iamcco/markdown-preview.vim', on_markdown)
" }}}
" ------------------ Completer --------------------- {{{
    let on_cxx = {'on_ft': ['c', 'cpp']}
    " call dein#add('maralla/completor.vim', {'if': '!has("nvim")'})
    call dein#add('autozimu/LanguageClient-neovim', {'name': 'lsp-client'})
    call dein#add('othree/csscomplete.vim', {'on_ft': ['css', 'html']})
    call dein#add('Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'})
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
    call dein#add('Shougo/neoinclude.vim', on_cxx)
    call dein#add('Shougo/neco-syntax')
    call dein#add('Shougo/neco-vim', {'on_ft': 'vim'})
    call dein#add('Shougo/neomru.vim')
    call dein#add('zchee/deoplete-asm')
    call dein#add('zchee/deoplete-clang')
    call dein#add('zchee/deoplete-jedi')
    call dein#add('fszymanski/deoplete-emoji')
    call dein#add('carlitux/deoplete-ternjs', {'on_ft': 'javascript'})
    call dein#add('Rip-Rip/clang_complete', on_cxx)
    " call dein#add('justmao945/vim-clang')
    " call dein#add('wokalski/autocomplete-flow')
    " call dein#add('vim-scripts/cmdline-completion')
" }}}
" ------------------ Appearance ------------------- {{{
    call dein#add('itchyny/lightline.vim')
    call dein#add('rakr/vim-one')
    call dein#add('morhetz/gruvbox')
    call dein#add('Yggdroot/indentLine', {'on_cmd': 'IndentLines*'})
    call dein#add('ryanoasis/vim-devicons')
    call dein#add('mhinz/vim-startify')
    call dein#add('gko/vim-coloresque')
    call dein#add('Reewr/vim-monokai-phoenix')
    call dein#add('crusoexia/vim-monokai')
    call dein#add('agude/vim-eldar')
    call dein#add('dunckr/vim-monokai-soda')
    call dein#add('wellsjo/wellsokai.vim')
    call dein#add('sjl/badwolf')
    call dein#add('KeitaNakamura/neodark.vim')
    call dein#add('muellan/am-colors')
    call dein#add('tomasr/molokai')
    " call dein#add('NLKNguyen/papercolor-theme', {'name': 'papercolor'})
    " call dein#add('nathanaelkane/vim-indent-guides')
    " call dein#add('xsunsmile/showmarks')
" }}}
" ------------------ Various ---------------------- {{{
    call dein#add('uguu-org/vim-matrix-screensaver', {'on_cmd': 'Matrix*'})
    call dein#add('wannesm/wmgraphviz.vim', {'on_ft': 'dot'})
    call dein#add('jpalardy/vim-slime', {'on_if': 'has("unix")'})
" }}}
" ------------------ UI Plugins ------------------- {{{
    call dein#add('rhysd/nyaovim-popup-tooltip')
    call dein#add('rhysd/nyaovim-mini-browser')
    call dein#add('rhysd/nyaovim-markdown-preview')
" }}}
" ------------------ C/C++ ---------------------
    " call dein#add('hari-rangarajan/CCTree')

    call s:config_hook()
    let f = s:confdir . '/_all_.vim'
    if filereadable(f) | exe 'so' f | endif
    call dein#end()
    call dein#call_hook('source')
    " call dein#save_state()
endif
" }}}
