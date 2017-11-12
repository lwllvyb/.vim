
fun! ctf#base64#encode(data)
py3 << EOF
import base64
_ = base64.b64encode(vim.eval('a:data').encode())
EOF
    return py3eval('_')
endf

fun! ctf#base64#decode(data)
py3 << EOF
import base64
_ = base64.b64decode(vim.eval('a:data').encode())
EOF
    return py3eval('_')
endf
