
fun! ctf#url#encode(data)
py3 << EOF
import urllib.request as _req
_ = _req.quote(vim.eval('a:data').encode())
EOF
    return py3eval('_')
endf

fun! ctf#url#decode(data)
py3 << EOF
import urllib.request as _req
_ = _req.unquote(vim.eval('a:data').encode())
EOF
    return py3eval('_')
endf
