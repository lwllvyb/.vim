" =============================================================================
" Filename:     vimrc
" Author:       luzhlon
" Description:  vim startup script
" Last Change:  2017/2/20
" =============================================================================

com! -nargs=+ Source so <sfile>:h/<args>

" load the options
Source option.vim
" load the default configs
Source default.vim
" load the local configs
sil! so ~/.config/local.vim

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

let g:_init_list = ['global']
try
    call env#init(g:_init_list)
catch
    au VimEnter * call env#init(g:_init_list)
endtry
