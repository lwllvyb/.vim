
local ffi = require 'ffi'

local window = {}

local nvim_win_get_buf      = vim.api.nvim_win_get_buf
local nvim_win_get_cursor   = vim.api.nvim_win_get_cursor
local nvim_win_set_cursor   = vim.api.nvim_win_set_cursor
local nvim_win_get_height   = vim.api.nvim_win_get_height
local nvim_win_set_height   = vim.api.nvim_win_set_height
local nvim_win_get_width    = vim.api.nvim_win_get_width
local nvim_win_set_width    = vim.api.nvim_win_set_width
local nvim_win_get_var      = vim.api.nvim_win_get_var
local nvim_win_set_var      = vim.api.nvim_win_set_var
local nvim_win_del_var      = vim.api.nvim_win_del_var
local nvim_win_get_option   = vim.api.nvim_win_get_option
local nvim_win_set_option   = vim.api.nvim_win_set_option
local nvim_win_get_position = vim.api.nvim_win_get_position
local nvim_win_get_tabpage  = vim.api.nvim_win_get_tabpage
local nvim_win_get_number   = vim.api.nvim_win_get_number
local nvim_win_is_valid     = vim.api.nvim_win_is_valid

local window = {}

-- function window:__index(key)
-- end

function window:buf()
    local nr = nvim_win_get_buf(self._id)
    if vim.api.nvim_buf_is_valid(nr) then
        return require 'nvim.buffer' (nr)
    end
end

function window:cursor(pos)
    if type(pos) == 'table' then
        return nvim_win_set_cursor(self._id, pos)
    else
        return nvim_win_get_cursor(self._id)
    end
end

function window:height(height)
    if type(height) == 'number' then
        return nvim_win_set_height(self._id, height)
    else
        return nvim_win_get_height(self._id)
    end
end

function window:width(width)
    if type(width) == 'number' then
        return nvim_win_set_width(self._id, width)
    else
        return nvim_win_get_width(self._id)
    end
end

function window:var(key, ...)
    if #{...} == 1 then
        return nvim_win_set_var(self._id, key, ...)
    else
        return nvim_win_get_var(self._id)
    end
end

function window:option(key, ...)
    if #{...} == 1 then
        return nvim_win_set_option(self._id, key, ...)
    else
        return nvim_win_get_option(self._id)
    end
end

function window:position()
    return nvim_win_get_position(self._id)
end

function window:tabpage()
    return nvim_win_get_tabpage(self._id)
end

function window:number()
    return nvim_win_get_number(self._id)
end

function window:is_valid()
    return nvim_win_get_is_valid(self._id)
end

ffi.cdef
[[
    typedef struct _nvim_window_
    {
        uint32_t _id;
    } _nvim_window;
]]

local Window = ffi.metatype('_nvim_window', window)

function window:__call(id)
    id = id or vim.api.nvim_get_current_win()
    local win = Window()
    win._id = id
    return win
end

return setmetatable(window, window)
