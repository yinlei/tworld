-------------------------------------------------------------------------------
-- create_base.lua
-------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local service = require "service"

local  _M = {}

function _M.create_base_anywhere(name, ...)
    local service = service.low("base")
    if service == 0 then
        return 1
    end

    local base = actor.sync(service)
    local succ, ret = base.create_base_anywhere(name, ...)
    if not succ or ret ~= 0 then
        ERROR_MSG("base create base entity " .. name .. " failed !!!")
        return 1
    end

    return ret
end

function _M.create_base_from_name(flag, type, key, login)
    local base = service.low("base")
    if base == 0 then
        ERROR_MSG("cann't find a base !!!")
        return
    end

    local store = actor.sync("store")
    local succ, ret = store.create_base_from_name(base, flag, type, key, login)
    if not succ then
        ERROR_MSG("stroe create_base_from_name failed !!!")
        return
    end

    return ret
end

return _M
