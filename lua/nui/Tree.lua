
-- TODO:
-- 1. add/remove child-node
-- 2. fold/expand node
-- 3. get the line-number of a node
-- 3. get a node by line-number

local Node = require 'nui.Node'

local TreeMethod = {}
local Tree = {__index = TreeMethod}

function TreeMethod:render()
end

function TreeMethod:update()
end

-- get a node by line number
function TreeMethod:getNode(line)
end

function NewTreeBuffer()
end
    
function Tree:new(tree)
    setmetatable(tree, self)

    local root = tree.rootNode assert(root)
    -- create tree window
    local direction = tree.direction or 'left'
    local filetype = tree.filetype or 'nui_tree'

    vim.command 'ene!'
    vim.command('set ft=' .. filetype)
    vim.command 'set bt=nofile'
    vim.command 'set bh=nowrite'
    tree._bufnr = vim.eval('bufnr("%")')
end

function Tree:expand(node)
    assert(node._root == self)

    local lines, generate_lines = {}, nil

    function generate_lines(node, deep)
        local text = string.rep(self.indent, deep)
        text = text .. node:onrender()
        table.insert(lines, text)
        -- if self is opened, expand childs recursively
        if not self._folded then
            for child in node:childs() do
                generate_lines(child, deep + 1)
            end
        end
    end

    generate_lines(node, node:deep())
    -- 递归遍历展开的节点，调用generate_lines函数
    -- 最后结果存在lines中
end
