XPTemplate priority=personal+

XPTvar $SParg ''

XPT fu " fun! ...
fun! `FOO^(`ARGS^)
    `BODY^
endf

XPT fdoc hint=File\ document
" =============================================================================
`" Filename:     `^
`" Author:       `^
`" Function:     `^
`" Last Change:  `^
`" =============================================================================`^

XPT comc hint=Command\ definition
com! -nargs=`^ call 
