" path to the chrome or the command to open chrome(or other modern browsers)
let g:mkdp_path_to_chrome = 'C:\Users\tom\AppData\Local\Google\Chrome\Application\chrome.exe'

" set to 1, the vim will open the preview window once enter the markdown buffer
let g:mkdp_auto_start = 0

" set to 1, the vim will auto open preview window when you edit the markdown file
let g:mkdp_auto_open = 0

" set to 1, the vim will auto close current preview window when change
" from markdown buffer to another buffer
let g:mkdp_auto_close = 0

" set to 1, the vim will just refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it just can be use in markdown file
let g:mkdp_command_for_global = 0
