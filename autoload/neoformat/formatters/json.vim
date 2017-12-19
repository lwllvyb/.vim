
fun! neoformat#formatters#json#enabled() abort
    return ['python']
endf

fun! neoformat#formatters#json#python() abort
    return {
        \ 'exe': 'python', 'stdin': 1
        \ 'args': ['-m', 'json.tool'],
        \ }
endf
