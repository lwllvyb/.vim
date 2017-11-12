" For dein {{{
let g:dein#types#git#clone_depth = 1
" }}}

" For echodoc {{{
let g:echodoc#enable_at_startup = 1
" }}}

" For neopairs {{{
let g:neopairs#enable = 1
" }}}

" For bookmarks {{{
let g:bookmark_show_warning = 1
let g:bookmark_show_toggle_warning = 1
let g:bookmark_no_default_key_mappings = 1
" }}}

" For vim-one {{{
" let g:one_allow_italics = 1
" }}}

" For slime.vim {{{
let g:slime_no_mappings = 1
" }}}

" For nerdtree {{{
let NERDTreeWinSize   = 27
let NERDTreeQuitOnOpen = 0
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
"      
" set ambiwidth=double
" let NERDTreeMinimalUI = 1
" }}}

" For table-mode {{{
let g:table_mode_disable_mappings = 1
" }}}

" For completor {{{
let g:completor_blacklist = ['tagbar', 'qf', 'netrw', 'unite', 'vimwiki', 'help', 'markdown']
" let g:completor_completion_delay = 120
" }}}

" For surround {{{
let g:surround_{char2nr('p')} = "print(\r)"
" }}}

" For gitgutter {{{
let g:gitgutter_enabled = 0
let g:gitgutter_map_keys = 0
" }}}

" For CSV.vim {{{
let g:csv_delim = ','
" }}}
