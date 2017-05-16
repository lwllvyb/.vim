let g:colors_name = 'pithy'

hi clear

hi SpecialKey      term=bold ctermfg=250 guifg=#bcbcbc
hi NonText         term=bold ctermfg=250 gui=bold guifg=#bcbcbc
hi Directory       term=bold ctermfg=25 guifg=#005faf
hi ErrorMsg        term=standout ctermfg=15 ctermbg=4 guifg=White guibg=Red
hi IncSearch       term=reverse cterm=reverse gui=reverse
hi Search          term=reverse ctermfg=238 ctermbg=227 guifg=#444444 guibg=#ffff5f
hi MoreMsg         term=bold ctermfg=64 gui=bold guifg=#5f8700
hi ModeMsg         term=bold cterm=bold ctermfg=64 gui=bold guifg=#5f8700
hi Question        term=standout ctermfg=64 gui=bold guifg=#5f8700
hi Title           term=bold ctermfg=102 gui=bold guifg=#878787
hi VisualNOS       term=bold,underline cterm=bold,underline gui=bold,underline
hi WarningMsg      term=standout ctermfg=162 guifg=#d70087
hi WildMenu        term=standout cterm=bold ctermfg=238 ctermbg=226 gui=bold guifg=#444444 guibg=#ffff00
hi FoldColumn      term=standout ctermfg=1 ctermbg=255 guifg=DarkBlue guibg=#eeeeee
hi DiffAdd         term=bold ctermfg=28 ctermbg=157 guifg=#008700 guibg=#afffaf
hi DiffChange      term=bold ctermfg=238 ctermbg=229 guifg=#444444 guibg=#ffffaf
hi DiffDelete      term=bold ctermfg=124 ctermbg=225 guifg=#af0000 guibg=#ffd7ff
hi DiffText        term=reverse ctermfg=31 ctermbg=230 guifg=#0087af guibg=#ffffd7
hi SignColumn      term=standout ctermfg=28 ctermbg=255 guifg=#008700 guibg=#eeeeee
hi SpellBad        term=reverse ctermfg=238 ctermbg=218 gui=undercurl guifg=#444444 guibg=#ffafd7 guisp=Red
hi SpellCap        term=reverse ctermfg=238 ctermbg=229 gui=undercurl guifg=#444444 guibg=#ffffaf guisp=Blue
hi SpellRare       term=reverse ctermfg=238 ctermbg=156 gui=undercurl guifg=#444444 guibg=#afff87 guisp=Magenta
hi SpellLocal      term=underline ctermfg=238 ctermbg=189 gui=undercurl guifg=#444444 guibg=#d7d7ff
hi Pmenu           ctermfg=238 ctermbg=252 guifg=#444444 guibg=#d0d0d0
hi PmenuSel        cterm=reverse ctermfg=238 ctermbg=252 gui=reverse guifg=#444444 guibg=#d0d0d0
hi PmenuSbar       ctermbg=7 guibg=Grey
hi PmenuThumb      ctermbg=0 guibg=Black
hi CursorColumn    term=reverse ctermbg=254 guibg=#e4e4e4
hi ColorColumn     term=reverse ctermbg=254 guibg=#e4e4e4
hi lCursor         guifg=bg guibg=fg
hi Comment         term=bold ctermfg=102 guifg=#878787
hi Constant        term=underline ctermfg=166 guifg=#d75f00
hi Special         term=bold ctermfg=238 guifg=#444444
hi Identifier      term=underline ctermfg=24 guifg=#005f87
hi Statement       term=bold ctermfg=162 guifg=#d70087
hi PreProc         term=underline ctermfg=25 guifg=#005faf
hi Type            term=underline cterm=bold ctermfg=162 gui=bold guifg=#d70087
hi Underlined      term=underline cterm=underline ctermfg=5 gui=underline guifg=SlateBlue
hi Ignore          ctermfg=15 guifg=bg
hi Error           term=reverse ctermfg=124 ctermbg=225 guifg=#af0000 guibg=#ffd7ff
hi Todo            term=standout cterm=bold ctermfg=35 ctermbg=255 gui=bold guifg=#00af5f guibg=#eeeeee
hi Number          ctermfg=166 guifg=#d75f00
hi Boolean         cterm=bold ctermfg=28 gui=bold guifg=#008700
hi Float           ctermfg=166 guifg=#d75f00
hi Function        ctermfg=238 guifg=#444444
hi Conditional     cterm=bold ctermfg=91 gui=bold guifg=#8700af
hi Repeat          cterm=bold ctermfg=91 gui=bold guifg=#8700af
hi Label           ctermfg=25 guifg=#005faf
hi Operator        ctermfg=31 guifg=#0087af
hi Keyword         guifg=#f92672
hi Define          ctermfg=25 guifg=#005faf
hi Macro           ctermfg=25 guifg=#005faf
hi PreCondit       ctermfg=31 guifg=#0087af
hi StorageClass    cterm=bold ctermfg=24 gui=bold guifg=#005f87
hi Structure       cterm=bold ctermfg=25 gui=bold guifg=#005faf
hi Typedef         cterm=bold ctermfg=162 gui=bold guifg=#d70087
hi Tag             ctermfg=28 guifg=#008700
hi Delimiter       ctermfg=31 guifg=#0087af
hi SpecialComment  cterm=bold ctermfg=102 gui=bold guifg=#878787
hi Debug           ctermfg=166 guifg=#d75f00
hi BufTabLineCurrent  ctermfg=238 ctermbg=254 guifg=#444444 guibg=#e4e4e4
hi BufTabLineActive  ctermfg=255 ctermbg=25 guifg=#eeeeee guibg=#005faf
hi BufTabLineHidden  ctermfg=255 ctermbg=31 guifg=#eeeeee guibg=#0087af
hi BufTabLineFill  ctermbg=24 guibg=#005f87
hi Global          ctermfg=25 guifg=#005faf

let s:normalfg = '#444444'
let s:normalbg = '#CCE8CF'
let s:cursorbg = '#526fff'

fun! s:hi(x, fg, bg, ...)
    let [x, fg, bg] = [a:x,
        \ empty(a:fg) ? '' : 'guifg='.a:fg,
        \ empty(a:bg) ? '' : 'guibg='.a:bg]
    exe 'hi' x fg bg join(a:000)
endf

com! -nargs=+ Hi call <SID>hi(<args>)

let s:bold         = 'gui=bold'
let s:red          = '#d70000'
let s:green        = '#008700'
let s:aqua         = '#0087af'
let s:purple       = '#8700af'
let s:orange       = '#d75f00'
let s:comment      = '#878787'
let s:wine         = '#8700af'
let s:pink         = '#d70087'
let s:blue         = '#005faf'
let s:olive        = '#5f8700'
let s:navy         = '#005f87'
let s:popupmenu_bg = '#d0d0d0'
let s:foreground   = s:normalfg

if has('win32')
    Hi 'VertSplit', s:normalbg, 'Black', 'font=新宋体:h13:cANSI:qDRAFT'
endif
Hi 'Normal', s:normalfg, s:normalbg
Hi 'TabLine', 0, s:normalbg, 'gui=underline'
Hi 'TabLineFill', 0, s:normalbg, 'gui=underline'
Hi 'Cursor', 0, s:cursorbg
Hi 'LineNr', '#b2b2b2', s:normalbg
Hi 'TabLineSel', 'White', '#4078f2', 'gui=bold,underline'
Hi 'MatchParen', '#e45649', '#f0f0f0', 'gui=bold,underline'
Hi 'StatusLine', 'White', '#a0a1a7'
Hi 'StatusLineNC', s:normalfg, '#f0f0f0'
Hi 'SpecialChar', s:aqua, s:normalbg
Hi 'Character', s:olive, s:normalbg
Hi 'String', s:olive, s:normalbg
Hi 'CursorLineNr', '#2B91AF', s:normalbg
Hi 'CursorLine', 0, '#99CCCC'
Hi 'Visual', 0, '#7ABBD2'
Hi 'Folded', s:foreground, '#afd7ff'
Hi 'Conceal', 0, s:normalbg
Hi 'Keyword', '#f92672', 0
Hi 'Exception', s:red, 0
Hi 'Include', s:red, 0

Hi 'htmlTitle', s:green, 0, s:bold
Hi 'htmlH1', s:green, 0, s:bold
Hi 'htmlH2', s:aqua, 0, s:bold
Hi 'htmlH3', s:purple, 0, s:bold
Hi 'htmlH4', s:orange, 0, s:bold
Hi 'htmlTag', s:comment, 0
Hi 'htmlTagName', s:wine, 0
Hi 'htmlArg', s:pink, 0
Hi 'htmlEndTag', s:comment, 0
Hi 'htmlString', s:blue, 0
Hi 'htmlScriptTag', s:comment, 0
Hi 'htmlBold', s:normalfg, 0, s:bold
Hi 'htmlItalic', s:comment, 0, s:bold
Hi 'htmlBoldItalic', s:navy, 0, s:bold
Hi 'htmlLink', s:blue, 0, s:bold
Hi 'htmlTagN', s:wine, 0, s:bold
Hi 'htmlSpecialTagName', s:wine, 0
Hi 'htmlComment', s:comment, 0
Hi 'htmlCommentPart', s:comment, 0

Hi 'markdownHeadingRule', s:pink, 0, s:bold
Hi 'markdownH1', s:pink, 0, s:bold
Hi 'markdownH2', s:orange, 0, s:bold
Hi 'markdownBlockquote', s:pink, 0
Hi 'markdownCodeBlock', s:olive, 0
Hi 'markdownCode', s:olive, 0
Hi 'markdownLink', s:blue, 0, s:bold
Hi 'markdownUrl', s:blue, 0
Hi 'markdownLinkText', s:pink, 0
Hi 'markdownLinkTextDelimiter', s:purple, 0
Hi 'markdownLinkDelimiter', s:purple, 0
Hi 'markdownCodeDelimiter', s:blue, 0

Hi 'mkdCode', s:olive, 0
Hi 'mkdLink', s:blue, 0, s:bold
Hi 'mkdURL', s:comment, 0
Hi 'mkdString', s:foreground, 0
Hi 'mkdBlockQuote', s:foreground, s:popupmenu_bg
Hi 'mkdLinkTitle', s:pink, 0
Hi 'mkdDelimiter', s:aqua, 0
Hi 'mkdRule', s:pink, 0

Hi 'vimCommand', s:pink, 0, 
Hi 'vimVar', s:navy, 0, 
Hi 'vimFuncKey', s:pink, 0, 
Hi 'vimFunction', s:blue, 0, s:bold
Hi 'vimNotFunc', s:pink, 0, 
Hi 'vimMap', s:red, 0, 
Hi 'vimAutoEvent', s:aqua, 0, s:bold
Hi 'vimMapModKey', s:aqua, 0, 
Hi 'vimFuncName', s:purple, 0, 
Hi 'vimIsCommand', s:foreground, 0, 
Hi 'vimFuncVar', s:aqua, 0, 
Hi 'vimLet', s:red, 0, 
Hi 'vimMapRhsExtend', s:foreground, 0, 
Hi 'vimCommentTitle', s:comment, 0, s:bold
Hi 'vimBracket', s:aqua, 0, 
Hi 'vimParenSep', s:aqua, 0, 
Hi 'vimNotation', s:aqua, 0, 
Hi 'vimOper', s:foreground, 0, 
Hi 'vimOperParen', s:foreground, 0, 
Hi 'vimSynType', s:purple, 0, 
Hi 'vimSynReg', s:pink, 0
Hi 'vimSynKeyRegion', s:green, 0, 
Hi 'vimSynRegOpt', s:blue, 0, 
Hi 'vimSynMtchOpt', s:blue, 0, 
Hi 'vimSynContains', s:pink, 0, 
Hi 'vimGroupName', s:foreground, 0, 
Hi 'vimGroupList', s:foreground, 0, 
Hi 'vimHiGroup', s:foreground, 0, 
Hi 'vimGroup', s:navy, 0, s:bold
Hi 'vimOnlyOption', s:blue, 0, 

delcom Hi
