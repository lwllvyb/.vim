
require 'pefile.cdef'

local ffi = require 'ffi'

local pefile = {
    SUBSYSTEM = {
        [0] = 'UNKNOWN', [1] = 'NATIVE',
        [2] = 'WINDOWS_GUI', [3] = 'WINDOWS_CUI',
        [5] = 'OS2_CUI', [7] = 'POSIX_CUI',
        [8] = 'NATIVE_WINDOWS', [9] = 'WINDOWS_CE_GUI',
        [10] = 'EFI_APPLICATION', [11] = 'EFI_BOOT_SERVICE_DRIVER',
        [12] = 'EFI_RUNTIME_DRIVER', [13] = 'EFI_ROM',
        [14] = 'XBOX', [16] = 'WINDOWS_BOOT_APPLICATION',
        [17] = 'XBOX_CODE_CATALOG'
    },
    MACHINE = {
        [0] = 'UNKNOWN',
        [0x0001] = 'TARGET_HOST', [0x014c] = 'I386', [0x0162] = 'R3000',
        [0x0166] = 'R4000', [0x0168] = 'R10000', [0x0169] = 'WCEMIPSV2',
        [0x0184] = 'ALPHA', [0x01a2] = 'SH3', [0x01a3] = 'SH3DSP',
        [0x01a4] = 'SH3E', [0x01a6] = 'SH4', [0x01a8] = 'SH5', [0x01c0] = 'ARM',
        [0x01c2] = 'THUMB', [0x01c4] = 'ARMNT', [0x01d3] = 'AM33',
        [0x01F0] = 'POWERPC', [0x01f1] = 'POWERPCFP', [0x0200] = 'IA64',
        [0x0266] = 'MIPS16', [0x0284] = 'ALPHA64', [0x0366] = 'MIPSFPU',
        [0x0466] = 'MIPSFPU16', [0x0520] = 'TRICORE', [0x0CEF] = 'CEF',
        [0x0EBC] = 'EBC', [0x8664] = 'AMD64', [0x9041] = 'M32R',
        [0xAA64] = 'ARM64', [0xC0EE] = 'CEE'
    },
    IMAGE_DOS_SIGNATURE  = 0x5A4D,
    IMAGE_NT_SIGNATURE   = 0x00004550,
    IMAGE_NT_OPTIONAL_HDR64_MAGIC = 0x20b,
    IMAGE_ORDINAL_FLAG64 = 0x8000000000000000,
    IMAGE_ORDINAL_FLAG32 = 0x80000000
}

local PEFILE = {}
local PEFILE_ATTR = {}

function PEFILE:__index(key)
    local noerr, value = pcall(function() return self.nt[key] end)
    if noerr then return value end

    value = rawget(PEFILE, key)
    if value then return value end

    local attr = PEFILE_ATTR[key]
    if attr then return attr(self) end
end

function PEFILE:getSection(va)
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

function PEFILE:getOffset(va)
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
function PEFILE_ATTR:exports()
    local file, nt = self.file, self.nt
end

local function vpairs(t, i)
    i = i and i-1 or 0
    return function() i = i + 1 return t[i] end
end
-- load the imports table
function PEFILE_ATTR:imports()
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
                end
                return import[key]
            end
        }
        setmetatable(import_table, import_table)

        function import_table:init()
            local bit = require 'bit'
            local flag = pefile[pe.PE32 and 'IMAGE_ORDINAL_FLAG32'
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

function PEFILE_ATTR:sections()
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

function pefile.load(filename)
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
    if dos.e_magic ~= pefile.IMAGE_DOS_SIGNATURE then
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
    if nt.Signature ~= pefile.IMAGE_NT_SIGNATURE then
        error('Not a valid PE file')
    end

    local PE32 = true
    if nt.OptionalHeader.Magic ==
       pefile.IMAGE_NT_OPTIONAL_HDR64_MAGIC
    then
        file:seek(offset_nt)
        nt = file:read(ffi.sizeof('IMAGE_NT_HEADERS64'))
        nt = ffi.cast('IMAGE_NT_HEADERS64 *', nt)
        PE32 = false
    end

    return setmetatable({
        nt = nt, file = file, PE32 = PE32, offset_nt = offset_nt
    }, PEFILE)
end

-- test
local pe
if ffi.os == 'Windows' then
    pe = pefile.load('D:/tool/Hash.exe')
else
    pe = pefile.load('/mnt/d/tool/Hash.exe')
end

-- for section in pe.sections:iter() do
for section in pe.sections() do
    print(section)
end

for imp in pe.imports() do
    print(imp.Name)
    for j = 1, #imp do
        print('\t', imp[j])
    end
end

local i = 3 / 0
return pefile

-- qrun.vim@luajit:
-- qrun.vim@vimlua:
