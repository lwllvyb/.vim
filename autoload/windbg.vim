
fun! DealWinDbgStruct()
    let n = line('.')
    let begin = n
    let base_pat = '^\s*\zs+\(0x\x\+\) \(\w\+\)\s*:\s*'     " offset, member
    let bit_pat = base_pat . 'Pos \(\d\+\), \d\+ Bit'       " bitpos
    let arr_pat = base_pat . '\(\[\d\+\]\)\s*\(.*\)'        " arr-type, arr-size
    let com_pat = base_pat . '\(.*\)'                       " member-type

    let ptr_pat = '\<Ptr32\>\s*\(.*\)'           " ptr-type
    while 1
        let text = getline(n)
        while match(text, ptr_pat) >= 0
            let text = substitute(text, ptr_pat, '\1 *', '')
        endw
        if match(text, bit_pat) >= 0
            let text = substitute(text, bit_pat, 'int \2:\3; \/\/ \1', '')
        elseif match(text, arr_pat) >= 0
            let text = substitute(text, arr_pat, '\4 \2\3; \/\/ \1', '')
        elseif match(text, com_pat) >= 0
            let text = substitute(text, com_pat, '\3 \2; \/\/ \1', '')
        else | break | endif
        call setline(n, text)
        let n += 1
    endw

    let end = n - 1
    let format = '%d,%d%s'
    sil! exe printf(format, begin, end, 's/\<Uint2B\>/uint16_t')
    sil! exe printf(format, begin, end, 's/\<Int2B\>/int16_t')
    sil! exe printf(format, begin, end, 's/\<Uint4B\>/uint32_t')
    sil! exe printf(format, begin, end, 's/\<Int4B\>/int32_t')
    sil! exe printf(format, begin, end, 's/\<Uint8B\>/uint64_t')
    sil! exe printf(format, begin, end, 's/\<UChar\>/uint8_t')
    sil! exe printf(format, begin, end, 's/\<Char\>/char')
    sil! exe printf(format, begin, end, 's/\<Wchar\>/wchar_t')
    sil! exe printf(format, begin, end, 's/\<Void\>/void')
    sil! exe printf(format, begin, end, 's/^\s*\zs_//')
endf
