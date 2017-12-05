
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
    local last = self._last
    if last then
        last:append(node)
    else
        self._first, self._last = node, node
    end
end

-- get child node by index
function Node:child(index)
    if type(index) == 'number' then
        local i, node = 0, self._first
        while node do
            if i == index then
                return node
            end
            i, node = i + 1, node._next
        end
    end
end

-- get iterator of child nodes
function Node:childs()
    local node = self._first
    return function()
        local ret = node
        node = node._next
        return ret
    end
end

-- get/set previous node
function Node:before(node)
    if not node then return self._prev end

    local parent = self._parent
    assert(parent, 'can not add node before root node')

    node._parent, node._root = self._parent, self._root

    node._prev = self._prev
    node._next, self._prev = self, node

    if self == parent._first then
        parent._first = node
    end
end

-- get/set next node
function Node:after(node)
    if not node then return self._next end

    local parent = self._parent
    assert(parent, 'can not add node after root node')

    node._parent, node._root = self._parent, self._root

    node._next = self._next
    node._prev, self._next = self, node

    if self == parent._last then
        parent._last = node
    end
end

-- remove self from siblings or remove self from parent
function Node:remove(node)
    if node then
        if type(node) == 'number' then
            local child = self:child(node)
            if child then return child:remove() end
        else
            assert(node._parent == self, 'node is not a child of self')
            return node:remove()
        end
    else
        local prev, next = self._prev, self._next
    end
end

-- fold a node
function Node:fold()
    assert(self._first, 'self is a leaf node')
    assert(not self._folded, 'self node is folded')
    
    self._folded = true
    self._height = 1

    -- TODO: update view
end

-- open a node
function Node:open()
    assert(self._first, 'self is a leaf node')
    assert(self._folded, 'self node is opened')
    -- set line as absolute with root
    local root = self._root
    if root then
        self._line = self:line() - root._line
    end

    self._folded = false
    local height = 1
    for child in self:childs() do
        height += child:_height
    end
    self._height = height

    -- TODO: update view
end

-- _line: if the node is rootNode, it is absolute line-number
--          else it is relative number after parent node
function Node:line(offset)
    offset = offset or 0
    if not self._root then
        return self._line + offset
    elseif self._first and not self._folded then
        -- opened node
        return self._root._line + self._line + offset
    else
        -- leaf node or closed node
        local upnode = self._prev or self._parent
        return upnode:line(upnode._height + offset)
    end
end

-- get the height of node, in number of lines
function Node:height()
    return self._height
end

function Node:clone()
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
