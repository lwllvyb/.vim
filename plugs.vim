" =============================================================================
" Filename:    plugs.vim
" Author:      luzhlon
" Date:        2017-08-29
" Description: load plugins and configs
" =============================================================================

fun! CheckRequire()
    let errs = []
    if !executable('git')
        call add(errs, 'Please install git')
    endif
    if !has('python3')
        call add(errs, 'Please install python3.x')
    endif
    if len(errs)
        for err in errs
            echom err
        endfo
        finish
    endif
endf

au VimEnter * call CheckRequire()

let dein_rtp = $CONFROOT . '/dein.vim'
if isdirectory(dein_rtp)
    let &rtp .= ',' . dein_rtp
else
    echom 'Please do `git submodule init` to install dein.vim'
    finish
endif

com! -nargs=* DeinInstall call dein#install(<f-args>)
com! -nargs=* DeinReinstall call dein#reinstall(<f-args>)
com! -nargs=* DeinUpdate call dein#update(<f-args>)
com! -nargs=+ DeinSource call dein#source(<f-args>)
com! DeinCheckInstall call dein#check_install()
com! DeinClearState call dein#clear_state()
com! DeinRecache call dein#recache_runtimepath()

let s:confdir = expand('<sfile>:h') . '/config/'
fun! s:config_hook()
    for [k, v] in items(dein#get())
        let f = s:confdir . v['normalized_name'] . '.vim'
        if filereadable(f)
            call dein#set_hook(k, 'hook_source', 'so ' . f)
        elseif isdirectory(f)
            let fs = glob(f . '/*.vim', 0, 1)
            fun! T() closure
                for f in fs|exe 'so' f|endfo
            endf
            call dein#set_hook(k, 'hook_source', funcref('T'))
        endif
    endfo
endf

if !exists('g:dein#cache_directory')
    let g:dein#cache_directory = glob('~/.cache/dein')
endif

if dein#load_state(g:dein#cache_directory)
    call dein#begin(g:dein#cache_directory)

    call dein#local('~/vimplugs')

    call dein#config('mdplus.vim', {'on_ft': 'markdown'})
    call dein#config('xmake.vim', {'depends': ['job.vim', 'qrun.vim']})
    call dein#config('cmode.vim', {'on_ft': ['c', 'cpp']})

    call dein#add('Shougo/dein.vim', {'rtp': dein_rtp})
    " ------------------ Utility --------------------
    call dein#add('Lokaltog/vim-easymotion')
    call dein#add('Shougo/denite.nvim')
    call dein#add('SirVer/ultisnips')
    call dein#add('honza/vim-snippets')
    call dein#add('terryma/vim-expand-region')
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-surround')
    call dein#add('vim-scripts/argtextobj.vim')
    call dein#add('godlygeek/tabular')
    call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTree*'})
    call dein#add('majutsushi/tagbar', {'on_cmd': 'Tagbar\w*'})
    " ------------------ Web -------------------------
    call dein#add('mattn/emmet-vim', {'name': 'emmet', 'on_ft': 'html'})
    call dein#add('gko/vim-coloresque', {'name': 'coloresque', 'on_ft': ['css', 'html', 'markdown']})
    " ------------------ Markdown ---------------------
    call dein#add('plasticboy/vim-markdown', {'on_ft': 'markdown'})
    call dein#add('iamcco/mathjax-support-for-mkdp')
    call dein#add('iamcco/markdown-preview.vim', {'on_ft': 'markdown'})
    " ------------------ Completer ---------------------
    call dein#add('Rip-Rip/clang_complete', {'on_ft': ['c', 'cpp']})
    call dein#add('maralla/completor.vim', {'if': '!has("nvim")'})
    call dein#add('Shougo/deoplete.nvim', {'if': 'has("nvim")'})
    call dein#add('vim-scripts/cmdline-completion')
    " ------------------ Appearance -------------------
    call dein#add('itchyny/lightline.vim')
    call dein#add('NLKNguyen/papercolor-theme', {'name': 'papercolor'})
    call dein#add('rakr/vim-one')
    call dein#add('morhetz/gruvbox')
    call dein#add('tomasr/molokai')
    " ------------------ Python -----------------------
    call dein#add('python-mode/python-mode', {'on_ft': 'python'})
    call dein#add('davidhalter/jedi-vim', {'on_ft': 'python'})
    " ------------------- Various ----------------------
    call dein#add('uguu-org/vim-matrix-screensaver')
    call dein#add('wannesm/wmgraphviz.vim', {'on_ft': 'dot'})
    call dein#add('jpalardy/vim-slime')

    " call dein#add('nathanaelkane/vim-indent-guides')
    " call dein#add('ryanoasis/vim-devicons')
    " call dein#add('xsunsmile/showmarks')

    call s:config_hook()
    call dein#end()
    call dein#call_hook('source')
    " call dein#save_state()
endif
