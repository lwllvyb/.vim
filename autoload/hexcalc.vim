
fun! hexcalc#init()
    confirm e Hex-Calc
    set bt=nowrite
    set nonumber
    setf vim

    nnoremap <buffer><silent><cr> :call hexcalc#calc()<cr>
    imap <buffer><c-cr> <c-o><cr>

    call append(0, '"--------------------------------------------------------')
    call append(1, '" Type your expression(vim), press Ctrl-Enter to evaluate')
    call append(2, '"--------------------------------------------------------')
    call append(3, '')

    norm! G
    startinsert
endf

fun! hexcalc#calc()
    " let expr = substitute(getline('.'), '\x\+', '0x&', 'g')
    try
        let val = eval(getline('.'))
        echo type(val) == v:t_number ?
                \ printf('0x%x, %d', val, val) :
                \ string(val)
    catch
        echohl WarningMsg
        echo v:exception
        echohl
    endt
endf
