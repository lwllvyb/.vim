
fun! hexcalc#init()
    confirm e Hex-Calc
    set bt=nowrite
    set nonumber modifiable
    setf vim

    inoremap <buffer><silent><m-;> <c-o>:call hexcalc#calc('=')<cr><end>
    inoremap <buffer><silent><m-e> <c-o>:call hexcalc#calc('e')<cr>
    inoremap <buffer><silent><m-cr> <c-o>:call hexcalc#calc('n')<cr><down><end>
    inoremap <buffer><silent><tab> <c-o>:call hexcalc#hex()<cr><end>

    call append(0, '"--------------------------------------------------------')
    call append(1, '" <m-;>  ----- EXPR = VAL')
    call append(2, '" <m-e>  ----- echo VAL')
    call append(3, '" <m-cr>  ----- EXPR \n VAL')
    call append(4, '" <tab>  ----- Toggle Hex')
    call append(5, '"--------------------------------------------------------')
    call append(6, '')

    norm! G
    startinsert
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

fun! hexcalc#hex()
    let l = getline('.')
    let v = eval(l)
    if type(v) != v:t_number | return | endif
    call setline('.', l =~ '^0x' ? printf('%d', v) : printf('0x%x',v))
endf
