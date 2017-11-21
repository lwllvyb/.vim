
local api                   = vim.api

local nvim_buf_get_lines    = api.nvim_buf_get_lines
local nvim_buf_set_lines    = api.nvim_buf_set_lines
local nvim_buf_line_count   = api.nvim_buf_line_count
local nvim_buf_set_option   = api.nvim_buf_set_option
local nvim_buf_get_option   = api.nvim_buf_get_option
local nvim_buf_get_var      = api.nvim_buf_get_var
local nvim_buf_set_var      = api.nvim_buf_set_var
local nvim_buf_set_name     = api.nvim_buf_set_name
local nvim_buf_get_name     = api.nvim_buf_get_name
local nvim_buf_is_valid     = api.nvim_buf_is_valid
local nvim_buf_get_mark     = api.nvim_buf_get_mark
local nvim_get_current_buf  = api.nvim_get_current_buf
local nvim_set_current_buf  = api.nvim_set_current_buf
local nvim_get_current_line = api.nvim_get_current_line
local nvim_set_current_line = api.nvim_set_current_line
local nvim_set_current_dir  = api.nvim_set_current_dir
local nvim_call_function    = api.nvim_call_function

local buffer_metatable

buffer_metatable = {
    __index = function(self, key)
        if type(key) == 'number' then
            return nvim_buf_get_lines(self._nr, key - 1, key, 1)
        else
            return rawget(buffer_metatable, key)
        end
    end,

    __newindex = function(self, key, value)
        if type(key) == 'number' then
            return nvim_buf_set_lines(self._nr, key - 1, key, 1, {value})
        end
    end,

    __len = function(self)
        return nvim_buf_line_count(self._nr)
    end,

    option = function(self, key, ...)
        if #{...} == 1 then
            return nvim_buf_set_option(self._nr, key, ...)
        else
            return nvim_buf_get_option(self._nr, key)
        end
    end,

    var = function(self, key, ...)
        if #{...} == 1 then
            if ... == nil then
                return nvim_buf_del_var(self._nr, key)
            else
                return nvim_buf_set_var(self._nr, key, ...)
            end
        else
            return nvim_buf_get_var(self._nr, key)
        end
    end,

    name = function(self, ...)
        if #{...} == 1 then
            return nvim_buf_set_name(self._nr, ...)
        else
            return nvim_buf_get_name(self._nr)
        end
    end,

    lines = function(self, begin, _end)
    end,

    is_valid = function(self)
        return nvim_buf_is_valid(self._nr)
    end,

    mark = function(self, name)
        return nvim_buf_get_mark(self._nr, name)
    end
}

return {
    command  = nvim_command,
    eval     = nvim_eval,
    mode     = nvim_get_mode,
    strwidth = nvim_strwidth,
    input    = nvim_input,
    feedkeys = nvim_feedkeys,

    buffer = function(nr)
        return setmetatable({
            _nr = nr or nvim_get_current_buf()
        }, buffer_metatable)
    end,

    call = function(name, ...)
        return nvim_call_function(name, {...})
    end,

    current_line = function(line)
        if line then
            return nvim_set_current_line(line)
        else
            return nvim_get_current_line()
        end
    end,

    current_dir = function(dir)
        if dir then
            return nvim_set_current_dir(dir)
        end
    end
}
