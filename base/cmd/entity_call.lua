--------------------------------------------------------------------------------
-- entity call
--------------------------------------------------------------------------------

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local global = require("lib.entity").global
local manager = require("lib.entity").manager

local server = require "server"
-------------------------------------------------------------------------------
local  _M = {}

function _M.command(f, context, ...)
    local id = context.id or 0
    local entity = manager.entity(id)
    p("entity call")

    if not entity then
        ERROR_MSG("cann't find entity !!!")
        return
    end

    local func = entity[f]
    if not func or type(func) ~= 'function' then
        ERROR_MSG("cann't find func(%s) !!!", f)
        return
    end

    return func(entity, ...)
end

return _M
