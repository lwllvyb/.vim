
local Tree = require 'Tree'

local tree = Tree:new()

local node2 = tree:append({data = 'root'})
                  :after({data = 'node1'})
                  :after({data = 'node2'})

node2:append({data = 'node21'}):after('node22')

node2:after({data = 'node3'}):after({data = 'node4'})

