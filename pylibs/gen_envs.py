
import winreg as wr
import platform, os
from subprocess import Popen, PIPE


def QuerySoftware(key, val = ''):
    key = ('SOFTWARE\\Wow6432Node\\'
            if platform.architecture()[0] == '64bit'
            else 'SOFTWARE\\')  + key
    try:
        k = wr.OpenKeyEx(wr.HKEY_LOCAL_MACHINE, key, access=wr.KEY_QUERY_VALUE)
        return wr.QueryValueEx(k, val)[0] if val else wr.QueryValue(k, val)
    except Exception:
        return ''
    finally:
        wr.CloseKey(k)

def gen_msvc():
    def find_vcvarsall(version = None):
        vs_vers = {
            '15.0' : 'VS150COMNTOOLS',
            '14.0' : 'VS140COMNTOOLS',
            '12.0' : 'VS120COMNTOOLS',
            '11.0' : 'VS110COMNTOOLS',
            '10.0' : 'VS100COMNTOOLS',
            '9.0'  : 'VS90COMNTOOLS',
            '8.0'  : 'VS80COMNTOOLS',
            '7.1'  : 'VS71COMNTOOLS',
            '7.0'  : 'VS70COMNTOOLS',
            '6.0'  : 'VS60COMNTOOLS',
            '5.0'  : 'VS50COMNTOOLS',
            '4.2'  : 'VS42COMNTOOLS'
        }
        # return the path of vcvarsall.bat firstly be found
        if not version:
            vers = list(vs_vers.keys())
            # sort the versions from large to small
            vers.sort(key = lambda x: float(x), reverse = True)
            for version in vers:
                path = find_vcvarsall(version)
                if path:
                    return path
        # return the path of vcvarsall.bat whoes version is version
        for path in [vspath + subpath \
                     for vspath in [os.environ.get(vs_vers.get(version), ''), \
                                    QuerySoftware('Microsoft\VisualStudio\SxS\VS7', version)]
                     for subpath in ['\\VC\\vcvarsall.bat', '\\VC\\Auxiliary\\Build\\vcvarsall.bat']]:
            if os.path.exists(path):
                return path
        return ''

    vv = find_vcvarsall()
    if not vv:
        return print('Can not find the vcvarsall.bat')

    print('Found vcvarsall.bat', vv)

    def get_vs_envs(arch):
        p = Popen(['cmd', '/k', 'call', vv, arch],
                stdin = PIPE, stdout = PIPE, stderr = PIPE)
        out, err = p.communicate('\r\n'.join([
            '@echo off',
            '@echo ---separator---',
            '@echo %INCLUDE%',
            '@echo %LIB%',
            '@echo %WindowsSdkDir%',
            '@echo %PATH%', '@exit'
        ]).encode())
        out = out.decode('gbk').split('\r\n')
        out = out[out.index('---separator---') + 1:]
        return {'INCLUDE': out[1].split(';'), 'LIB': out[3].split(';'),
                'WindowsSdkDir': out[5], 'PATH': out[7].split(';') }

    config = { a: get_vs_envs(a) for a in ['x86', 'x64'] }
    return config

def gen_clang():
    llvm = QuerySoftware('LLVM\\LLVM')
    if not llvm:
        return print('Can not find the directory of LLVM')

    print('LLVM path:', llvm)

    config = {}
    if platform.system() == 'Windows':
        l = llvm + '\\share\\clang\\clang-format.py'
        config['clang_format_py'] = l if os.path.exists(l) else ''
        l = llvm + '\\share\\clang\\clang-rename.py'
        config['clang_rename_py'] = l if os.path.exists(l) else ''
        config['clang_library_path'] = os.path.join(llvm, 'bin')
    else:
        l = glob.glob('/usr/share/clang/clang-format-*/clang-format.py')
        config['clang_format_py'] = l[0] if l else ''
        l = glob.glob('/usr/share/clang/clang-rename-*/clang-rename.py')
        config['clang_rename_py'] = l[0] if l else ''

    return config

def write_conf(fname, conf):
    import glob, json
    confdir = os.path.expanduser(os.path.join('~', '.config', 'envs.vim'))
    if not os.path.isdir(confdir):
        os.mkdir(confdir, True)
    f = os.path.join(confdir, fname)
    with open(f, 'w+') as f:
        json.dump(conf, f)

def main():
    print('Operating system:', platform.system(),
            platform.architecture()[0], platform.version(), platform.node())

    print()
    print('------------------- Searching MSVC ... -------------------')
    write_conf('msvc.json', {'envs#vs': gen_msvc()})

    print()
    print('------------------- Searching LLVM and clang ... -------------------')
    write_conf('clang.json', gen_clang())

if __name__ == '__main__':
    main()
