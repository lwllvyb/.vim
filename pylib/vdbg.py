from process import Process

class Debugger:
    _cmd = {'go_on':'','start':'','next' :'','step' :'','quit':''}
    on_quit = lambda p: None
    def __init__(self):
        pass
    def exec(self, cmd):
        self.proc.exec(cmd)
    def start(self, target):
        self.proc = Process(target)
        self.proc.read(self.on_output)
        self.proc.on_quit = self.on_quit
    def go_on(self):
        self.proc.exec(self._cmd['go_on'])
    def next(self):
        self.proc.exec(self._cmd['next'])
    def step(self):
        self.proc.exec(self._cmd['step'])
    def quit(self):
        self.proc.exec(self._cmd['quit'])
        self.proc.kill()

class CDB(Debugger):
    _cmd = {
        'go_on' : 'g',
        'start'    : 'g',
        'next'     : 'p',
        'step'     : 't',
        'quit'     : 'q'
    }
    def start(self, target):
        Debugger.start(self, ['cdb', target, '-lines', '-ee c++', '-2', '-g'])
        self.exec('l+t')      #进入源代码模式
        self.exec('l+s')      #进入源代码模式
    def bp(self, src, line):
        self.exec('bp `%s:%d`' % (src, line))

class GDB(Debugger):
    _cmd = {
        'go_on' : 'c',
        'start' : 'r',
        'next'  : 'n',
        'step'  : 's',
        'quit'  : 'q'
    }
    def start(self, target):
        Debugger.start(self, ['gdb', target, '-q'])
        # self.exec('set prompt')      #关闭命令提示符
    def bp(self, src, line):
        self.exec('b %s:%d' % (src, line))

if __name__ == "__main__":
    dbg = CDB()
    dbg.on_output = lambda p, d: print(d)
    dbg.start('b:\\Desktop\\inject\\build\\inject.exe')
