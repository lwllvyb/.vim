
local t = {
__call = function(self, ...)
    print(...)
end
}

setmetatable(t, t)

t(1,2,3)
