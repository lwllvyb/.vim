
if !has_key(g:, 'CONFIG')
    let CONFIG = {}
endif

if !has_key(CONFIG, 'colorscheme')
    let CONFIG.colorscheme = 'one'
endif

if !has_key(CONFIG, 'background')
    let CONFIG.background = 'light'
endif
