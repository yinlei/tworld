-------------------------------------------------------------------------------
-- entity_rpc.lua
-------------------------------------------------------------------------------
local table_unpack = table.unpack or unpack

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG

local entity_rpc = require("packet.entity_rpc")

local _M = {
    ID = entity_rpc.ID,
}

function _M.handle(agent, message)
    local entity = agent.entity
    if not entity then
        ERROR_MSG("agent attached entity is nil !!!")
        return
    end

    local name = message.name
    local f = entity[name]
    if not f or type(f) ~= 'function' then
        ERROR_MSG("entity can't find %s func !!!", name)
        return
    end

    f(entity, table_unpack(message.args))
end

return _M
