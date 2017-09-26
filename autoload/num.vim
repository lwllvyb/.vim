
" 数字转二进制串
fun! num#bin(...)
    let n = a:0 ? a:1: @"
    py3 _ = bin(int(vim.eval('n')))[2:]
    return py3eval('_')
endf

" Binary to digit
fun! num#2(...)
    let n = a:0 ? a:1: @"
    py3 _ = int(vim.eval('n'), 2)
    return py3eval('_')
endf

fun! num#8(...)
    let n = a:0 ? a:1: @"
    py3 _ = int(vim.eval('n'), 8)
    return py3eval('_')
endf

fun! num#16(...)
    let n = a:0 ? a:1: @"
    py3 _ = int(vim.eval('n'), 16)
    return py3eval('_')
endf
