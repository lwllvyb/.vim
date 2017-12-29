
-- TODO:
-- 3. 
-- 3. get a node by line-number

local Node = require 'nui.Node'

local Tree = {}
Tree.__index = Tree
Tree.__tostring = Node.__tostring
setmetatable(Tree, Node)
-- export to global
NUITree = Tree

-- indent text
Tree.indent = '  '

local nvim_command = vim.api.nvim_command
local nvim_curwin = vim.api.nvim_get_current_win
local nvim_curbuf = vim.api.nvim_get_current_buf
local nvim_setwidth = vim.api.nvim_win_set_width
local nvim_callfunc = vim.api.nvim_call_function
local nvim_setbufopt = vim.api.nvim_buf_set_option

local buf2tree = {}             -- bufnr -> tree

function Tree:CurNode()
    self = self or Tree:CurTree()
    local curline = nvim_callfunc('line', {'.'})
    return self[curline]
end

function Tree:CurTree()
    local tree = buf2tree[nvim_curbuf()]
    assert(tree, 'there is no tree in this buffer')
    return tree
end

function Tree:new(tree)
    tree = setmetatable(tree or {}, Tree)

    tree._root = tree
    tree._parent = nil      -- root node haven't parent node
    tree._opened = false
    tree._height = 1
    tree._line = tree.baseline or 2 -- the begin line, 1-based

    -- position of the tree window
    tree.position = tree.position or 'left'
    -- with of the tree window
    tree.winwidth = tree.winwidth or 23
    tree.name = tree.name or 'NUITREE'

    -- render the text
    tree:_initview()
    return tree
end

function Tree:_initview()
    nvim_command 'vertical winc s'
    nvim_command ('e ' .. self.name)

    for i = 1, self._line - 1 do
        nvim_callfunc('append', {'.', ''})
    end

    local bufnr = nvim_curbuf()
    self._bufnr = bufnr
    buf2tree[bufnr] = self

    nvim_command 'setl nomod nonu bt=nofile ft=nuitree'
    nvim_command 'setl nowrap'
    nvim_setwidth(nvim_curwin(), self.winwidth)
    self:updateview()
end

-- function Tree:_addopen(node) self._openodes[node._line] = node end
-- function Tree:_delopen(node) self._openodes[node._line] = nil end

function Tree:before(node)
    error('can not add node before root node')
end

function Tree:after(node)
    error('can not add node after root node')
end

function Tree:deep()
    return -1
end

-- function Tree:line() return self._line end

return Tree
