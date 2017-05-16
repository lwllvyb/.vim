" =============================================================================
" Filename:     autoload/align.vim
" Author:       luzhlon
" Function:     Align this line by last line according last character
" Last Change:  2017/3/25
" =============================================================================

fun! s:Count(c)
    let prevline = getline(line('.') - 1)
    let pattern = printf('%s[^%s]*$', a:c, a:c)
    if !empty(prevline)
        let n = match(prevline, pattern)
        return n < 0 ? 0: n - col('.') + 2
    endif
    return 0
endf

fun! align#(c)
    let l = lib#curstr()
    let n = s:Count(a:c)
    if l =~ a:c . '$'
        return n ? repeat(a:c, n) : "\<tab>"
    else
        return "\<tab>"
    endif
endf
