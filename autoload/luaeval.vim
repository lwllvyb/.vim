
fun! luaeval#()
    e LuaEval
    set bt=nowrite
    set ft=lua

    call append(0, '-- <c-cr> Execute lua chunk')
    call append(1, '-- <m-cr> Eval lua expression')
    call append(2, '')

    startinsert

    imap <expr><buffer><c-cr> "\<cr>" . luaeval#exec()
    imap <expr><buffer><m-cr> "\<cr>" . luaeval(getline('.'))
endf

fun! luaeval#exec()
    let @- = execute('lua ' . getline('.'))
    return "\<esc>" . '"-p'
endf

fun! luaeval#eval()
endf
