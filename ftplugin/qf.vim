
setl wrap
setl nonumber

if exists('&winhl')
    hi QFNormal guibg=#f0f0f0
    setl winhl=Normal:QFNormal
endif

nmap <silent><buffer> <c-j> :cn<cr>
nmap <silent><buffer> <c-k> :cp<cr>
