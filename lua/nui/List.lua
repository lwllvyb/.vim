
local nvim = require 'nvim'

local List = {}

function List:new(list)
    list = list or {
        column_width = 10
    }
    setmetatable(list, List)
    return list
end

function List:update()
    
end
