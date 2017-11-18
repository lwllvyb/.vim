
local api = vim.api

local buffer_metatable

buffer_metatable = {
    __index = function(self, key)
        if type(key) == 'number' then
            return api.nvim_buf_get_lines(self._nr, key - 1, key, 1)
        else
            return rawget(buffer_metatable, key)
        end
    end,

    __newindex = function(self, key, value)
        if type(key) == 'number' then
            return api.nvim_buf_set_lines(self._nr, key - 1, key, 1, {value})
        end
    end,

    __len = function(self)
        return api.nvim_buf_line_count(self._nr)
    end,

    option = function(self, key, ...)
        if #{...} == 1 then
            return api.nvim_buf_set_option(self._nr, key, ...)
        else
            return api.nvim_buf_get_option(self._nr, key)
        end
    end,

    var = function(self, key, ...)
        if #{...} == 1 then
            if ... == nil then
                return api.nvim_buf_del_var(self._nr, key)
            else
                return api.nvim_buf_set_var(self._nr, key, ...)
            end
        else
            return api.nvim_buf_get_var(self._nr, key)
        end
    end,

    name = function(self, ...)
        if #{...} == 1 then
            return api.nvim_buf_set_name(self._nr, ...)
        else
            return api.nvim_buf_get_name(self._nr)
        end
    end,

    lines = function(self, begin, _end)
    end,

    is_valid = function(self)
        return api.nvim_buf_is_valid(self._nr)
    end,

    mark = function(self, name)
        return api.nvim_buf_get_mark(self._nr, name)
    end
}

return {
    command = api.nvim_command,
    eval = api.nvim_eval,
    mode = api.nvim_get_mode,
    strwidth = api.nvim_strwidth,
    input = api.nvim_input,
    feedkeys = api.nvim_feedkeys,

    buffer = function(nr)
        return setmetatable({
            _nr = nr or api.nvim_get_current_buf()
        }, buffer_metatable)
    end,

    call = function(name, ...)
        return api.nvim_call_function(name, {...})
    end,

    current_line = function(line)
        if line then
            return api.nvim_set_current_line(line)
        else
            return api.nvim_get_current_line()
        end
    end,

    current_dir = function(dir)
        if dir then
            return api.nvim_set_current_dir(dir)
        end
    end
}
