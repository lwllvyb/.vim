
local bufsetlines = vim.api.nvim_buf_set_lines
local nvim_command = vim.api.nvim_command
local nvim_setbufopt = vim.api.nvim_buf_set_option

local Node = {}
Node.__index = Node

local function InitNode(self, node)
    node = setmetatable(node or {}, Node)
    node._root, node._height = self._root, 1
    return node
end

local function UpdateAfterLine(node)
    local line = node:endline() + 1
    local after = node:after()
    if after then
        if  then
            
        end
    end
end

-- get renderde text
function Node:render()
    local root = self._root
    local bufnr = root._bufnr
    local indent = root.indent  -- indent text
    local line = self._line     -- current line to render
    local content = {}          -- content lines

    -- generate content
    local gen_content, setline
    function gen_content(node, deep)
        node._line = line; root[line] = node
        local text = string.rep(indent, deep)
        text = text .. node:onrender()
        table.insert(content, text)
        line = line + 1
        -- if self is opened, expand childs recursively
        if node._opened then
            for child in node:childs() do
                gen_content(child, deep + 1)
            end
        end
    end

    gen_content(self, self:deep())
    -- print(self._line, line) vim.api.nvim_call_function('getchar', {})
    if self._opened then            -- open a node
        bufsetlines(bufnr, self._line - 1, self._line, 0, content)
    else                            -- fold a node
        self._opened = true
        bufsetlines(bufnr, self._line - 1, self:endline(), 0, content)
        self._opened = false
    end

    -- set line for after nodes
    -- ...
    -- set line for after nodes of parent
    -- ...
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

function Node:_setline(line)
    self._line = line; self._root[line] = self
    if self._opened then
        for child in self:childs() do
            line = line + 1
            line = child:_setline(line)
        end
    end
    return line
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

    if type(node) == 'number' then
        for i = node - 1 , 0, -1 do
            if not self then return end
            self = self._prev
        end
        return self
    end

    node = InitNode(self, node)
    node._parent = self._parent

    node._prev = self._prev
    node._next, self._prev = self, node

    if self == parent._first then
        parent._first = node
    end
    return node
end

-- get/set next node
function Node:after(node)
    if not node then return self._next end

    if type(node) == 'number' then
        for i = 0, node - 1 do
            if not self then return end
            self = self._next
        end
        return self
    end

    node = InitNode(self, node)
    node._parent = self._parent

    node._next = self._next
    node._prev, self._next = self, node

    local parent = self._parent
    if self == parent._last then
        parent._last = node
    end
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

function Node:updateview(height)
    nvim_setbufopt(bufnr, 'modifiable', true)
    local content = self:render()
    nvim_setbufopt(bufnr, 'modifiable', false)
end

-- fold a node
function Node:fold()
    assert(self._first, 'self is a leaf node')
    assert(self._opened, 'self node is folded')
    self._opened = false
    self._deep = nil
    self:updateview()
end

-- open a node
function Node:open()
    assert(self._first, 'self is a leaf node')
    assert(not self._opened, 'self node is opened')

    local parent = self._parent
    if not parent or parent._opened then
        -- set line as absolute with root
        self._deep = self:deep()
        self._opened = true
        self:updateview(1)
    end
end

function Node:toggle()
    if self._opened == nil then return end
    if self._opened then
        return self:fold()
    else
        return self:open()
    end
end

-- start line number of a node
function Node:line(offset)
    return self._line + (offset or 0)
end

-- end line number of a node
function Node:endline()
    if self._opened then
        local last = self:last()
        return last and last:endline() or self._line
    else
        return self._line
    end
end

-- get the height of node, in number of lines
function Node:height()
    if self._opened then
        return self:endline() - self._line + 1
    else
        return 1
    end
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
    if self._opened then
        return self._deep
    else
        return 1 + self._parent:deep()
    end
end

function Node:move2parent()
    if self and self._parent then
        nvim_command(tostring(self._parent._line))
    end
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
        return '  ' .. tostring(self.data)
    else
        return (self._opened and '- ' or '+ ') .. self.data
    end
end

function Node:onclick()
end

return Node
-- qrun.vim@vimlua:
