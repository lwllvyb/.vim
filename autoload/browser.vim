" =============================================================================
" Filename:     plugin/browser.vim
" Author:       luzhlon
" Function:     browser utils
" Last Change:  2017/3/25
" =============================================================================

py3 << EOF
from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.common.keys import Keys

_browser = None
def _bw():
    global _browser
    if not _browser:
        _browser = webdriver.Chrome() # Get local session of Chrome
    return _browser
EOF

fun! browser#get(url)
py3 _bw().get(vim.eval('a:url'))
endf

fun! browser#quit()
py3 _bw().close()
endf
