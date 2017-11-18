
local nvim = require 'nvim'

nvim.command('e LUAEVAL')

local buf = nvim.buffer()
buf:option('bt', 'nowrite')
