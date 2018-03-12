
import platform, os
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

def main():
    print('Operating system:', platform.system(),
            platform.architecture()[0], platform.version(), platform.node())

    if platform.system() == 'Windows':
        print()
        print('------------------- Searching MSVC ... -------------------')
        msvc = gen_msvc()
        # print('Write INCLUDE Path to .clang_complete')
        # with open('.clang_complete', 'w') as f:
        #     f.write('\n'.join(['-DDEBUG', '-I.'] + ['-I"%s"' % path for path in msvc['x86']['INCLUDE']]))
        return msvc

import vim
_ = main()
vim.command('let g:_ = py3eval("_")')
