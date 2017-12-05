
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
