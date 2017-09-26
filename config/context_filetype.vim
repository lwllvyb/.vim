
if !exists('g:context_filetype#filetypes')
    let g:context_filetype#filetypes = {
        \ 'html': [
            \ {'filetype': 'javascript',
                \ 'start': '<script.*>',
                \ 'end' : '</script>'},
            \ {'filetype': 'css',
                \ 'start': '<style.*>',
                \ 'end': '</style>'}],
        \ 'vim': [
            \ {'filetype': 'python',
                \ 'start': '^\s*py\%[thon]3\? <<\s*\(\h\w*\)',
                \ 'end' : '^\1'},
            \ {'filetype': 'lua',
                \ 'start': '^\s*lua <<\s*\(\h\w*\)',
                \ 'end': '^\1'}],
        \ 'markdown': [
            \ {'filetype': 'python',
                \ 'start': '^\s*```python$', 'end' : '`^\s*``'},
            \ {'filetype': 'cpp',
                \ 'start': '^\s*```cpp$', 'end' : '^\s*```'},
            \ {'filetype': 'lua',
                \ 'start': '^\s*```lua$', 'end' : '^\s*```'},
            \ {'filetype': 'c',
                \ 'start': '^\s*```c$', 'end' : '^\s*```'},
            \ {'filetype': 'asm',
                \ 'start': '^\s*```asm$', 'end' : '^\s*```'}]}
endif
