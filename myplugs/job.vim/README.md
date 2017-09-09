
跨neovim与vim8的job接口

## 函数

* job#start(command_line, options) ---- 启动一个job并返回，options为一个字典，`onout` `onerr` `onexit`分别指定job标准输出、标准错误、退出时的回调函数
* job#success(job) -------------------- 检测job是否启动成功
* job#running(job) -------------------- 检测job是否还在运行

下面两个函数用于回调，可作为job#start函数options参数的`onout` `onerr`传入

* job#cb_add2qf(job, data) ------------ 将job输出的数据投递到quickfix
* job#cb_add2qfb(job, data) ----------- 将job输出的数据投递到quickfix，并滚动到底部

## Features

* Windows下自动转换子进程的输出编码为utf8
