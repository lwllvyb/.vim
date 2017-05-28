au! VimEnter * call denite#custom#map(
      \ 'insert',
      \ '<c-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
au! VimEnter * call denite#custom#map(
      \ 'insert',
      \ '<c-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)

nnoremap <c-p> :Denite buffer<cr>
