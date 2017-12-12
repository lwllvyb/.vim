
require 'pefile.cdef'

local ffi = require 'ffi'

local PEFile = {
    IMAGE_DOS_SIGNATURE  = 0x5A4D,
    IMAGE_NT_SIGNATURE   = 0x00004550,
    IMAGE_NT_OPTIONAL_HDR64_MAGIC = 0x20b,
    IMAGE_ORDINAL_FLAG64 = 0x8000000000000000,
    IMAGE_ORDINAL_FLAG32 = 0x80000000
}
PEFile.__index = setmetatable(PEFile, PEFile)

local PEFileAttr = {}

function PEFile:__index(key)
    local noerr, value = pcall(function() return self.nt[key] end)
    if noerr then return value end

    value = rawget(PEFile, key)
    if value then return value end

    local attr = PEFileAttr[key]
    if attr then return attr(self) end
end

function PEFile:__tostring()
    return string.format('PEFile[%s]', self.path)
end

function PEFile:getSection(va)
    for i = 1, #self.sections do
        local section = self.sections[i]
        local sec_offset = va - section.VirtualAddress

        if va >= section.VirtualAddress and
           sec_offset < section.Misc.VirtualSize
        then
            return section, sec_offset
        end
    end
end

function PEFile:getOffset(va)
    local section, sec_offset = self:getSection(va)
    if not section then error('Invalid VA ' .. va) end
    return section.PointerToRawData + sec_offset
end

local function readstr(file)
    local t = {}
    while true do
        local c = file:read(1)
        if string.byte(c) == 0 then break end
        table.insert(t, c)
    end
    return table.concat(t)
end

-- load the exports table
function PEFileAttr:exports()
    local file, nt = self.file, self.nt
end

local function vpairs(t, i)
    i = i and i-1 or 0
    return function() i = i + 1 return t[i] end
end
-- load the imports table
function PEFileAttr:imports()
    local file, nt, pe = self.file, self.nt, self
    local data = nt.OptionalHeader.DataDirectory + 1

    local offset = self:getOffset(data.VirtualAddress)
    local count = data.Size / ffi.sizeof('IMAGE_IMPORT_DESCRIPTOR')

    local imports = {__call = vpairs}
    setmetatable(imports, imports)
    -- print('Imports count:', count)
    for i = 1, count do
        -- import is the ffi object
        file:seek('set', offset)
        offset = offset + ffi.sizeof('IMAGE_IMPORT_DESCRIPTOR')

        local import = file:read(ffi.sizeof('IMAGE_IMPORT_DESCRIPTOR'))
        import = ffi.cast('IMAGE_IMPORT_DESCRIPTOR *', import)
        if import.FirstThunk == 0 then break end

        -- impobj is a lua table, a wrapper of import
        local import_table = {
            __index = function(self, key)
                if key == 'Name' then
                    file:seek('set', pe:getOffset(import.Name))
                    local name = readstr(file)
                    rawset(self, 'Name', name)
                    return name
                elseif key then
                    return import[key]
                end
            end
        }
        setmetatable(import_table, import_table)

        function import_table:init()
            local bit = require 'bit'
            local flag = PEFile[pe.PE32 and 'IMAGE_ORDINAL_FLAG32'
                                        or  'IMAGE_ORDINAL_FLAG64']
            local thunktype = pe.PE32 and
                  'IMAGE_THUNK_DATA32' or 'IMAGE_THUNK_DATA64'
            local pthunktype = thunktype .. ' *'
            local thunksize = ffi.sizeof(thunktype)

            -- next position of IMAGE_THUNK_DATA
            thunk_va = tonumber(import.DUMMYUNIONNAME.OriginalFirstThunk)
            local cur_pos = pe:getOffset(thunk_va)
            -- print(string.format('FirstThunk: %x,  OriginalFirstThunk: %x, thunksize: %d',
            --                 self.FirstThunk, self.DUMMYUNIONNAME.OriginalFirstThunk, thunksize))
            
            for i = 0, 0x7FFFFFFF do
                -- load a IMAGE_THUNK_DATA
                file:seek('set', cur_pos)
                local thunk = file:read(thunksize)
                thunk = ffi.cast(pthunktype, thunk)
                cur_pos = cur_pos + thunksize

                local func = tonumber(thunk.u1.Function)
                if func == 0 then break end

                -- print(string.format('%d %x %d', i, func, func))

                if bit.band(func, flag) == 0 then
                    -- import by function name
                    file:seek('set', pe:getOffset(func) + 2)
                    table.insert(self, readstr(file))
                else
                    -- import by number
                    table.insert(self, func)
                end
            end
        end

        import_table:init()
        table.insert(imports, import_table)
        imports[import_table.Name] = import_table
    end

    self.imports = imports return imports
end

local SECTION = ffi.metatype('IMAGE_SECTION_HEADER', {
    __index = function(self, key)
        if key == 'name' then
            return ffi.string(self.Name)
        end
    end,
    __tostring = function(self)
        return string.format('%s, %x, %x',
                    self.name, self.VirtualAddress, #self)
    end,
    __len = function(self) return tonumber(self.Misc.VirtualSize) end
})

function PEFileAttr:sections()
    local file, nt = self.file, self.nt

    local offset_section = self.offset_nt +
          ffi.offsetof('IMAGE_NT_HEADERS64', 'OptionalHeader') + 
          nt.FileHeader.SizeOfOptionalHeader
    file:seek('set', offset_section)

    local sections = {__call = vpairs}
    setmetatable(sections, sections)

    for i = 1, nt.FileHeader.NumberOfSections do
        local buf = file:read(ffi.sizeof('IMAGE_SECTION_HEADER'))
        if not buf then
            error('load IMAGE_SECTION_HEADER failure')
        end

        local section = SECTION()
        -- ffi.copy(ffi.cast('void *', section), buf)
        ffi.copy(section, buf, ffi.sizeof('IMAGE_SECTION_HEADER'))
        table.insert(sections, section)
        sections[section.name] = section
    end

    self.sections = sections return sections
end

function PEFile:new(filename)
    -- read the headers
    file = io.open(filename, 'rb')
    if not file then
        error('can not open file ' .. filename)
    end

    -- load the IMAGE_NT_HEADERS
    local dos = file:read(ffi.sizeof('IMAGE_DOS_HEADER'))
    if not dos then
        error('can not load the IMAGE_DOS_HEADER')
    end

    dos = ffi.cast('IMAGE_DOS_HEADER *', dos)
    if dos.e_magic ~= PEFile.IMAGE_DOS_SIGNATURE then
        error('Not a valid PE file')
    end

    local offset_nt = dos.e_lfanew
    file:seek('set', tonumber(offset_nt))
    local nt = file:read(ffi.sizeof('IMAGE_NT_HEADERS32'))
    if not nt then
        error('can not load the IMAGE_NT_HEADERS')
    end

    nt = ffi.cast('IMAGE_NT_HEADERS32 *', nt)
    -- print(string.format('%x', tonumber(nt.Signature)))
    if nt.Signature ~= PEFile.IMAGE_NT_SIGNATURE then
        error('Not a valid PE file')
    end

    local PE32 = true
    if nt.OptionalHeader.Magic ==
       PEFile.IMAGE_NT_OPTIONAL_HDR64_MAGIC
    then
        file:seek(offset_nt)
        nt = file:read(ffi.sizeof('IMAGE_NT_HEADERS64'))
        nt = ffi.cast('IMAGE_NT_HEADERS64 *', nt)
        PE32 = false
    end

    return setmetatable({
        nt = nt, file = file, PE32 = PE32,
        offset_nt = offset_nt, path = filename
    }, PEFile)
end

return PEFile

-- qrun.vim@luajit:
-- qrun.vim@vimlua:
