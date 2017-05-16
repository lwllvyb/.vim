from proc import Process

class Debugger(Process):
    _cmd = {'cont':'','start':'','next' :'','step' :'','quit':''}
    def start(self, target):
        pass
    def cont(self):
        self.exec(self._cmd['cont'])
    def next(self):
        self.exec(self._cmd['next'])
    def step(self):
        self.exec(self._cmd['step'])
    def quit(self):
        if not self.ended:
            self.exec(self._cmd['quit'])

class CDB(Debugger):
    _cmd = {
        'start': 'g', 'cont' : 'g', 'next' : 'p',
        'step' : 't', 'quit' : 'q'
    }
    def __init__(self, target):
        super(CDB, self).__init__(['cdb', target, '-lines', '-ee c++', '-2', '-g'])
        self.exec('l+t')      #进入源代码模式
        self.exec('l+s')      #进入源代码模式
    def start(self, target):
        pass
    def bp(self, src, line):
        self.exec('bp `%s:%d`' % (src, line))

class GDB(Debugger):
    _cmd = {
        'start' : 'r', 'cont'  : 'c', 'next'  : 'n',
        'step'  : 's', 'quit'  : 'q'
    }
    def __init__(self, target):
        super(GDB, self).__init__(['gdb', target, '-q'])
        # self.exec('set prompt')      #关闭命令提示符
    def start(self, target):
        pass
    def bp(self, src, line):
        self.exec('b %s:%d' % (src, line))

if __name__ == "__main__":
    dbg = CDB('b:\\Desktop\\inject\\build\\inject.exe')
    while 1:
        d = dbg.read()
        if not d and dbg.ended:
            break
        print(d)
