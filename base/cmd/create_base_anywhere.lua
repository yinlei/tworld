-------------------------------------------------------------------------------
-- create_base_anywhere.lua
-- global->base
-------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local factory = require("base.core").factory

local  _M = {}

function _M.command(type, ...)
    local entity = factory.create_base(type, ...)
    if not entity then
        return 1
    end

    return 0
end

return _M
