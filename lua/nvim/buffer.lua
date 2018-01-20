
local ffi = require 'ffi'

local buffer = {}

local nvim_buf_get_lines    = vim.api.nvim_buf_get_lines
local nvim_buf_set_lines    = vim.api.nvim_buf_set_lines
local nvim_buf_line_count   = vim.api.nvim_buf_line_count
local nvim_buf_set_option   = vim.api.nvim_buf_set_option
local nvim_buf_get_option   = vim.api.nvim_buf_get_option
local nvim_buf_get_var      = vim.api.nvim_buf_get_var
local nvim_buf_set_var      = vim.api.nvim_buf_set_var
local nvim_buf_set_name     = vim.api.nvim_buf_set_name
local nvim_buf_get_name     = vim.api.nvim_buf_get_name
local nvim_buf_is_valid     = vim.api.nvim_buf_is_valid
local nvim_buf_get_mark     = vim.api.nvim_buf_get_mark

function buffer:__index(key)
    if type(key) == 'number' then
        return nvim_buf_get_lines(self._nr, key - 1, key, 1)[1]
    else
        return rawget(buffer, key)
    end
end

function buffer:__newindex(key, value)
    if type(key) == 'number' then
        return nvim_buf_set_lines(self._nr, key - 1, key, 1, {value})
    end
end

function buffer:__len()
    return nvim_buf_line_count(self._nr)
end

function buffer:option(key, ...)
    if #{...} == 1 then
        return nvim_buf_set_option(self._nr, key, ...)
    else
        return nvim_buf_get_option(self._nr, key)
    end
end

function buffer:var(key, ...)
    if #{...} == 1 then
        if ... == nil then
            return nvim_buf_del_var(self._nr, key)
        else
            return nvim_buf_set_var(self._nr, key, ...)
        end
    else
        return nvim_buf_get_var(self._nr, key)
    end
end

function buffer:name(...)
    if #{...} == 1 then
        return nvim_buf_set_name(self._nr, ...)
    else
        return nvim_buf_get_name(self._nr)
    end
end

function buffer:lines(begin, _end)
    return nvim_buf_get_lines(self._nr, key - 1, key, 1)
end

function buffer:is_valid()
    return nvim_buf_is_valid(self._nr)
end

function buffer:mark(name)
    return nvim_buf_get_mark(self._nr, name)
end

ffi.cdef
[[
    typedef struct _nvim_buffer_
    {
        uint32_t _nr;
    } _nvim_buffer;
]]

local Buffer = ffi.metatype('_nvim_buffer', buffer)

function buffer:__call(nr)
    nr = nr or vim.api.nvim_get_current_buf()
    local buf = Buffer()
    buf._nr = nr
    return buf
end

return setmetatable(buffer, buffer)
