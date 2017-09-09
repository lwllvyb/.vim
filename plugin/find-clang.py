"""
File: find-clang.py
Author: luzhlon
Email: luzhlon@email.com
Github: https://github.com/luzhlon
Description: Find the clang(LLVM) from registry or ENVIRONMENT
"""

import platform, os, glob

def QuerySoftware(key, val = ''):
    import winreg as wr
    """
    Query the registry under HKEY_LOCAL_MACHINE\SOFTWARE[\Wow6432Node]
    """

    _key = 'SOFTWARE\\'
    if platform.architecture()[0] == '64bit':
        _key += 'Wow6432Node\\'
    key = _key + key
    try:
        k = wr.OpenKeyEx(wr.HKEY_LOCAL_MACHINE, key, access=wr.KEY_QUERY_VALUE)
        return wr.QueryValueEx(k, val)[0] if val else wr.QueryValue(k, val)
    except Exception:
        return ''
    finally:
        wr.CloseKey(k)

d = {}

if platform.system() == 'Windows':
    path = QuerySoftware('LLVM\\LLVM')
    d = {'path': path}

    format_py = path + '/share/clang/clang-format.py'
    rename_py = path + '/share/clang/clang-rename.py'

    vim.vars['clang_format_py'] = format_py if os.path.exists(format_py) else ''
    vim.vars['clang_rename_py'] = rename_py if os.path.exists(rename_py) else ''
else:
    l = glob.glob('/usr/share/clang/clang-format-*/clang-format.py')
    if l: vim.vars['clang_format_py'] = l[0]
    l = glob.glob('/usr/share/clang/clang-rename-*/clang-rename.py')
    if l: vim.vars['clang_rename_py'] = l[0]

_ = d
# print(d)
