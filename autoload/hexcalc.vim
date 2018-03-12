
fun! hexcalc#init()
    confirm e Hex-Calc
    set bt=nowrite
    set nonumber modifiable
    setf vim

    inoremap <buffer><silent><m-;> <c-o>:call hexcalc#calc('=')<cr><end>
    inoremap <buffer><silent><m-e> <c-o>:call hexcalc#calc('e')<cr>
    inoremap <buffer><silent><m-cr> <c-o>:call hexcalc#calc('n')<cr><down><end>
    inoremap <buffer><silent><m-.> <esc>bciw<c-r>=hexcalc#toggle_hex(@@)<cr>
    inoremap <buffer><c-v> <c-r>+
    inoremap <buffer><m-v> 0x<c-r>+

    syn match vimString /\%<5l<[^>]\+>/ containedin=vimLineComment

insert
" --------------------------------------------------------
"  <m-;> ==> EXPR = VAL  <m-cr> ==> EXPR \n VAL
"  <m-e> ==> echo VAL    <m-.>  ==> Toggle Hex/Dec
"  <c-v> ==> <paste>     <m-v>  ==> 0x<paste>
" --------------------------------------------------------
.

    call feedkeys("Go\<c-u>\<cr>", 'n')
endf

fun! hexcalc#calc(...)
    let t = a:0 ? a:1 : '='
    " let expr = substitute(getline('.'), '\x\+', '0x&', 'g')
    try
        let l = getline('.')
        let val = eval(l)
        if type(val) != v:t_number
            let val = string(val)
        endif
        if t == 'n'
            call append('.', val)
        elseif t == '='
            call setline('.', printf('%s = %s', l, val))
        elseif t == 'e'
            echo val (type(val) == v:t_number ? printf('0x%x', val): '')
        endif
    catch
        echohl WarningMsg
        echo v:exception
        echohl
    endt
endf

fun! hexcalc#toggle_hex(numstr)
    let v = eval(a:numstr)
    return a:numstr =~? '^0x' ? printf('%d', v) : printf('0x%x',v)
endf
