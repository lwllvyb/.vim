
-- TODO:
-- 1. add/remove child-node
-- 2. fold/expand node
-- 3. get the line-number of a node
-- 3. get a node by line-number

local Node = require 'nui.Node'

local Tree = {}
Tree.__index = Tree
setmetatable(Tree, Node)

-- indent text
Tree.indent = '  '

function Tree:new(tree)
    tree = setmetatable(tree or {}, self)

    tree._root = tree
    tree._parent = nil      -- root node haven't parent node
    tree._opened = false

    -- the begin line
    tree._line = tree.baseline or 2
    -- position of the tree window
    tree.position = tree.position or 'left'
    -- with of the tree window
    tree.winwidth = tree.winwidth or 23

    -- render the text
end

function Tree:expand(node)
    assert(node and node._root == self)

    local view = self._view

end

function Tree:shrink(node)
    assert(node and node._root == self)
end

function Tree:curnode()
end

function Tree:before(node)
    error('can not add node before root node')
end

function Tree:after(node)
    error('can not add node after root node')
end
