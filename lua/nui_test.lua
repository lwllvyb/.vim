
local Tree = require 'nui.Tree'

tree = Tree:new({data = 'root'})

tree:append {data = 'node0'}
    :append {data = 'node1'}
    :append {data = 'node2'}
    :append({data = 'node3'})
    :append({data = 'node4'})

node2 = tree:child(2)

node2:append {data = 'node21'}
     :append {data = 'node22'}

-- tree:open()

-- print(tree:render())

-- qrun.vim@vimlua:
