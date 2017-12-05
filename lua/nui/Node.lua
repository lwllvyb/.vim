
local Tree = require 'nui.Tree'

local Node = {}

local NodeAttr, NodeMethod = {}, {}

-- create a node in a tree
function Node:new(node)
    node = node or {}
    setmetatable(node, self)

    return node
end

-- TODO
function Node:addChild(node)
    node = Node:new(node)
    node._parent = self
    table.insert(self, node)
end

function Node:nextSibling()
end

function Node:prevSibling()
end

-- TODO
function Node:removeChild(node)
    for i, v in ipairs(self) do
        if v == node then
            table.remove(self, i)
        end
    end
end

-- TODO
function Node:fold()
    self._folded = true
    self._height = 1
end

-- TODO
function Node:expand()
    self._folded = false
    local height = 1
    for _, child in ipairs(self) do
        height += child:getHeight()
    end
    self._height = height
end

-- _line: if the node is rootNode, it is absolute line-number
--          else it is relative number after parent node
function Node:getLine()
    local line = 0
    while self do
        line = line + self._line
        self = self._parent
    end
    return line
end

-- find the rootNode
function Node:getRoot()
    while self._parent do
        self = self._parent
    end
    return self
end

-- get the height of node, in number of lines
function Node:getHeight()
end

function Node:clone()
end

function Node:childs()
    local i = 0
    return function() i = i + 1 return self[i] end
end

----------------- Event handler -----------------

function Node:onRender()
    -- this function decided the content to show
    -- it should return a list contained content lines
end

function Node:onClick()
end

function Node:onEnter()
end

-- qrun.vim@vimlua:
