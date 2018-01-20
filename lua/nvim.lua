
local api                   = vim.api

local nvim_get_current_buf  = api.nvim_get_current_buf
local nvim_set_current_buf  = api.nvim_set_current_buf
local nvim_get_current_line = api.nvim_get_current_line
local nvim_set_current_line = api.nvim_set_current_line
local nvim_set_current_dir  = api.nvim_set_current_dir
local nvim_call_function    = api.nvim_call_function

return {
    command  = nvim_command,
    eval     = nvim_eval,
    mode     = nvim_get_mode,
    strwidth = nvim_strwidth,
    input    = nvim_input,
    feedkeys = nvim_feedkeys,

    buffer = function(nr)
        nr = nr or nvim_get_current_buf()
        return setmetatable({
            _nr = nr or 
        }, buffer)
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
