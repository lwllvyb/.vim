
au User asyncomplete_setup
    \ call asyncomplete#register_source(
        \ asyncomplete#sources#necovim#get_source_options({
        \ 'name': 'necovim',
        \ 'whitelist': ['vim'],
        \ 'completor': funcref('asyncomplete#sources#necovim#completor'),
        \ }))
