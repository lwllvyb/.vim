
setl wrap
setl nonumber

if exists('&winhl')
    setl winhl=Normal:NormalQF
endif

nmap <silent><buffer> <c-j> :cn<cr>
nmap <silent><buffer> <c-k> :cp<cr>
