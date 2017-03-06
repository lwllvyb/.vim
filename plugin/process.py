import subprocess
from subprocess import PIPE
import threading

class Process(subprocess.Popen):
    bufsize = 1024
    def __init__(self, cmd, **args):
        args.update({'stdin': PIPE, 'stdout': PIPE, 'stderr': PIPE})
        super(Process, self).__init__(cmd, **args)
    def read(self, callback):
        '''启动一个线程循环读取输出，并传递给回调函数'''
        def foo():
            while 1:
                l = self.stdout.read(Process.bufsize)
                if not l and not self.alive():
                    self.on_quit(self);break
                callback(self, l.decode(encoding=g_encoding, errors='replace'))
        threading.Thread(target=foo).start()
    def readline(self, callback):
        '''启动一个线程循环读取一行输出，并传递给回调函数'''
        def foo():
            while 1:
                l = self.stdout.readline()
                if not l and not self.alive():
                    self.on_quit(self);break
                callback(self, l.decode(encoding=g_encoding, errors='replace'))
        threading.Thread(target=foo).start()
    def on_quit(self):
        pass
    def write(self, data):
        '''向标准输入里写入一段数据'''
        if type(data) is str:
            data = data.encode()
        self.stdin.write(data)
    def exec(self, data):
        '''向标准输入里写入一行命令'''
        self.write(data)
        self.stdin.write(b'\n')
        self.stdin.flush()
    def alive(self):
        '''判断子进程是否存活'''
        return self.poll() == None
