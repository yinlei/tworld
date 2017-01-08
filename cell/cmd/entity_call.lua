-------------------------------------------------------------------------------
-- entity_call.lua
-- base->cell
-------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local manager = require ("lib.entity").manager

local  _M = {}

function _M.command(func, service, ...)
    local id = service.id

    local entity = manager.entity(id)

    if not entity then
        ERROR_MSG("cann't find entity !!!")
    end

    local f = assert(entity[func])
    return f(entity, ...)
end

return _M
