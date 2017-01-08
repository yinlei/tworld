--------------------------------------------------------------------------------
-- create_cell.lua
--------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local service = require "service"

local  _M = {}

function _M.create_cell_in_new_space(name, s, ...)
    p("create_cell_in_new_space", name, s, ...)
    local cell = service.low("cell")
    if cell == 0 then
        return
    end

    local _cell = actor.sync(cell)
    local succ, ret = _cell.create_cell_in_new_space(name, s, ...)
    if not succ then
        ERROR_MSG("global create_cell_in_new_spaced failed !!! ")
        return
    end

    return ret
end

return _M
