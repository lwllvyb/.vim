
local ffi = require 'ffi'

local PEFile = require 'pefile'
local Tree = require 'nui.Tree'

local pe
if ffi.os == 'Windows' then
    pe = PEFile:new('D:/tool/Hash.exe')
else
    pe = PEFile:new('/mnt/d/tool/Hash.exe')
end

-- for section in pe.sections:iter() do
for section in pe.sections() do
    print(section)
end

local petree = Tree:new {data = tostring(pe)}

for imp in pe.imports() do
    petree:append {data = imp.Name}
    local node = petree:last()
    for j = 1, #imp do
        -- print('\t', imp[j])
        node:append {data = imp[j]}
    end
end

petree:open()

-- qrun.vim@vimlua:
