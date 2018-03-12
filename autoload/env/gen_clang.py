
import platform, os
import glob, json
from subprocess import Popen, PIPE

def QuerySoftware(key, val = ''):
    import winreg as wr

    key = ('SOFTWARE\\Wow6432Node\\'
            if platform.architecture()[0] == '64bit'
            else 'SOFTWARE\\')  + key
    try:
        k = wr.OpenKeyEx(wr.HKEY_LOCAL_MACHINE, key, access=wr.KEY_QUERY_VALUE)
        return wr.QueryValueEx(k, val)[0] if val else wr.QueryValue(k, val)
    except Exception:
        return ''

def Glob(d):
    config = {}
    for k, v in d.items():
        l = glob.glob(v)
        if l:
            config[k] = l[0]
            print(k, ':', l[0])
    return config

def gen_clang():
    if platform.system() == 'Windows':
        llvm = QuerySoftware('LLVM\\LLVM')
        if not llvm:
            print('Can not find the directory of LLVM')
            return

        print('LLVM path:', llvm)

        return Glob({
            'clang_library_path': os.path.join(llvm, 'bin\\libclang.dll'),
            'clang_format_py': os.path.join(llvm, 'share\\clang\\clang-format.py'),
            'clang_rename_py': os.path.join(llvm, 'share\\clang\\clang-rename.py')
            })
    else:
        libclang = '/usr/lib/llvm-*/lib/libclang.so.1'
        return Glob({
            'clang_format_py': '/usr/share/clang/clang-format-*/clang-format.py',
            'clang_rename_py': '/usr/share/clang/clang-rename-*/clang-rename.py',
            # 'clang_library_path': libclang,
            'deoplete#sources#clang#libclang_path': libclang,
            'deoplete#sources#clang#clang_header': '/usr/include/clang/*/include'
            })

def main():
    print('Operating system:', platform.system(),
            platform.architecture()[0], platform.version(), platform.node())
    print('------------------- Searching LLVM and clang ... -------------------')
    return gen_clang()

import vim
_ = gen_clang()
vim.command('let g:_ = py3eval("_")')
