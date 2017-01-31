" =============================================================================
" Filename:     plugin/ctf.vim
" Author:       luzhlon
" Function:     CTF解题过程中常用功能的实现
" Last Change:  2017/1/30
" =============================================================================

if !has('python3')|finish|endif

py3 << EOF
import urllib.request as request
import base64, re
morse_code_table = {
    'A': '.-',     'B': '-...',   'C': '-.-.',
    'D': '-..',    'E': '.',      'F': '..-.',
    'G': '--.',    'H': '....',   'I': '..',
    'J': '.---',   'K': '-.-',    'L': '.-..',
    'M': '--',     'N': '-.',     'O': '---',
    'P': '.--.',   'Q': '--.-',   'R': '.-.',
    'S': '...',    'T': '-',      'U': '..-',
    'V': '...-',   'W': '.--',    'X': '-..-',
    'Y': '-.--',   'Z': '--..',

    '0': '-----',  '1': '.----',  '2': '..---',
    '3': '...--',  '4': '....-',  '5': '.....',
    '6': '-....',  '7': '--...',  '8': '---..',
    '9': '----.'
}
t = {}
for k in morse_code_table:
    t[morse_code_table[k]] = k
morse_code_table.update(t)

def bufcont():
    return vim.eval('@u')
def morse_decode():
    list = re.split('[^\.-]+', bufcont())
    ret = []
    for i in list:
        ret.append(morse_code_table[i])
    return ''.join(ret)

def morse_encode():
    ret = []
    ss = bufcont().upper()
    for k in ss:
        ret.append(morse_code_table[k])
    print(ret)
    return ' '.join(ret)
EOF

com! MorseEncode call <SID>MorseEncode()
com! MorseDecode call <SID>MorseDecode()
com! Base64Encode call <SID>Base64Encode()
com! Base64Decode call <SID>Base64Decode()
com! UrlEncode    call <SID>UrlEncode()
com! UrlDecode    call <SID>UrlDecode()

com! UnicodeDecode s/u\(\x\+\)/\=nr2char('0x'.submatch(1)+0)/g

fun! s:del2reg()
    norm! gg0vG$"ud
endf
fun! s:paste(str)
    let @u = a:str
    norm "uP
endf

let s:morse_0 = '.'
let s:morse_1 = '_'

fun! s:MorseEncode()
    call s:del2reg()
    call s:paste(py3eval('morse_encode()'))
endf
fun! s:MorseDecode()
    call s:del2reg()
    call s:paste(py3eval('morse_decode()'))
endf
fun! s:UrlEncode()
    call s:del2reg()
    call s:paste(py3eval('request.quote(bufcont())'))
endf
fun! s:UrlDecode()
    call s:del2reg()
    call s:paste(py3eval('request.unquote(bufcont())'))
endf
fun! s:Base64Encode()
    call s:del2reg()
    call s:paste(py3eval('base64.b64encode(bufcont().encode())'))
endf
fun! s:Base64Decode()
    call s:del2reg()
    call s:paste(py3eval('base64.b64decode(bufcont().encode())'))
endf
