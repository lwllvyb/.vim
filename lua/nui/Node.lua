
local Node = {}
Node.__index = Node

local function InitNode(self, node)
    node = setmetatable(node or {}, Node)
    node._root, node._height = self._root, 1
    return node
end

-- get renderde text
function Node:render()
    local lines, generate_lines = {}, nil
    local root = self._root

    function generate_lines(node, deep)
        local text = string.rep(root.indent, deep)
        text = text .. node:onrender()
        table.insert(lines, text)
        -- if self is opened, expand childs recursively
        if node._opened then
            for child in node:childs() do
                generate_lines(child, deep + 1)
            end
        end
    end

    generate_lines(self, self:deep())
    return lines
end

function Node:__tostring()
    return table.concat(self:render(), '\n')
end

function Node:__len()
    local len = 0
    for child in self:childs() do
        len = len + 1
    end
    return len
end

-- append a child after self
function Node:append(node)
    local last = self._last
    if last then
        node = last:after(node)
    else
        node = InitNode(self, node)
        node._parent = self
        self._first, self._last = node, node
    end
    -- ensure self is a non-leaf node
    self._opened = self._opened or false
    self:_addheight(1)
    return self
end

function Node:tree()
    return self._root
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
        if node then node = node._next end
        return ret
    end
end

-- get/set previous node
function Node:before(node)
    if not node then return self._prev end

    node = InitNode(self, node)
    node._parent = self._parent

    node._prev = self._prev
    node._next, self._prev = self, node

    if self == parent._first then
        parent._first = node
    end
    self._parent:_addheight(1)
    return node
end

-- get/set next node
function Node:after(node)
    if not node then return self._next end

    node = InitNode(self, node)
    node._parent = self._parent

    node._next = self._next
    node._prev, self._next = self, node

    local parent = self._parent
    if self == parent._last then
        parent._last = node
    end
    self._parent:_addheight(1)
    return node
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

local bufsetlines = vim.api.nvim_buf_set_lines
local nvim_setbufopt = vim.api.nvim_buf_set_option

function Node:updateview(height)
    local content = self:render()
    height = height or #content
    local start = self:line() - 1
    local end_ = start + height
    -- print(start, height, #content)

    nvim_setbufopt(bufnr, 'modifiable', true)
    bufsetlines(self._root._bufnr, start, end_, 0, content)
    nvim_setbufopt(bufnr, 'modifiable', false)
end

-- fold a node
function Node:fold()
    assert(self._first, 'self is a leaf node')
    assert(self._opened, 'self node is folded')
    
    local old_height = self._height
    self:_addheight(1 - old_height)
    self._opened = false
    self._height = 1

    self:updateview(old_height)
end

-- open a node
function Node:open()
    assert(self._first, 'self is a leaf node')
    assert(not self._opened, 'self node is opened')

    local parent = self._parent
    if not parent or parent._opened then
        -- set line as absolute with root
        local root = self._root
        if root then
            self._line = self:line()
        end

        self._opened = true
        self._height = 1
        local height = 0
        for child in self:childs() do
            height = height + child._height
        end
        self:_addheight(height)

        self:updateview(1)
    end
end

function Node:_addheight(n)
    if self._opened then
        self._height = self._height + n
        local parent = self._parent
        if parent then
            parent:_addheight(n)
        end
    end
end

-- _line: if the node is rootNode, it is absolute line-number
--          else it is relative number after parent node
function Node:line(offset)
    offset = offset or 0
    if not self._parent then
        -- root node
        return self._line + offset
    elseif self._opened then
        -- opened node
        return self._line + offset
    else
        -- leaf node or folded node
        local prev = self._prev
        if prev then
            return prev:line(prev._height + offset)
        else
            return self._parent:line(1 + offset)
        end
    end
end

-- get the height of node, in number of lines
function Node:height()
    return self._height
end

function Node:first()
    return self._first
end

function Node:last()
    return self._last
end

-- get the deep of node
function Node:deep()
    local i = 0
    self = self._parent
    while self do
        i = i + 1
        self = self._parent
    end
    return i
end

-- is a leaf node
function Node:isleaf()
    return self._opened == nil
end

function Node:clone()
end

----------------- Event handler -----------------

function Node:onrender()
    -- this function decided the content to show
    -- it should return a list contained content lines
    if self._opened == nil then
        return '  ' .. self.data
    else
        return (self._opened and '- ' or '+ ') .. self.data
    end
end

function Node:onclick()
end

return Node
-- qrun.vim@vimlua:
