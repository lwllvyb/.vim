" =============================================================================
" Filename:     vimrc
" Author:       luzhlon
" Description:  vim startup script
" Last Change:  2017/2/20
" =============================================================================

com! -nargs=+ Source so <sfile>:h/<args>

" load the options
Source option.vim

" load the local config {{{
fun! s:load_envs(file)
    let f = a:file
    let cont = readfile(f)
    let envs = json_decode(join(cont))
    for [k, v] in items(envs)
        let g:{k} = v
    endfo
endf

fun! s:load_local()
    let confdir = glob('~/.config/envs.vim')
    if isdirectory(confdir)
        call map(split(glob(confdir . '/*.json'), "\n"), {i,v->s:load_envs(v)})
        " the init.vim of envs: for local configuration
        sil! exe 'so' confdir.'/init.vim'
    endif
endf

call s:load_local()
Source default.vim
" }}}

" load the plugins
Source plugs.vim

" do the local config {{{
if has_key(g:, 'CONFIG')
    if has_key(CONFIG, 'colorscheme')
        sil! exe 'colorscheme' CONFIG['colorscheme']
    endif
    if has_key(CONFIG, 'background')
        let &background = CONFIG['background']
    endif
endif

if !exists('$TEMP') && has('unix')
    let $TEMP = '/tmp'
endif " }}}

" load gui config {{{
if has('nvim')
    fun! GuiRunning()
        return exists('g:GuiLoaded') && g:GuiLoaded == 1 || has('gui_running')
    endf
else
    if has('gui_running')
        Source ginit.vim
    else
        Source alt-mapping.vim
    endif
endif " }}}
