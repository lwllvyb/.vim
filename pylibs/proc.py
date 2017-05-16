from subprocess import PIPE
from collections import deque
import subprocess
import threading
import platform as plat

if plat.system() == 'Windows':
    encoding                = 'gbk'
    startupinfo             = subprocess.STARTUPINFO()
    startupinfo.dwFlags     = subprocess.STARTF_USESHOWWINDOW
    startupinfo.wShowWindow = subprocess.SW_HIDE
else:
    encoding    = 'utf-8'
    startupinfo = None

procs = {}

class Process(subprocess.Popen):
    bufsize = 1024
    def __init__(self, cmd, **args):
        args.update({'stdin': PIPE, 'stdout': PIPE,
            'stderr': PIPE, 'startupinfo': startupinfo})
        super(Process, self).__init__(cmd, **args)
        self._deque = deque()
        self.ended = 0
        q = self._deque; r = self.stdout.read1
        procs[self.pid] = self
        def work():
            while 1:
                d = r(Process.bufsize)
                if not d and not self.alive():
                    self.ended = 1
                    break
                q.append(d.decode(errors='replace', encoding=encoding))
        threading.Thread(target = work).start()
    def read(self):
        q = self._deque
        return q.popleft() if len(q) else ''
    def write(self, data):
        '''向标准输入里写入一段数据'''
        if type(data) is str:
            data = data.encode()
        self.stdin.write(data)
    def exec(self, data):
        '''向标准输入里写入一行命令'''
        self.write(data+'\n')
        self.stdin.flush()
    def alive(self):
        '''判断子进程是否存活'''
        return self.poll() == None

if __name__ == "__main__":
    p = Process('cmd /c dir')
    while 1:
        d = p.read()
        if not d and p.ended:
            break
        print(d)
