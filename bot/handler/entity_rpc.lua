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

function _M.handle(bot, message)
    local name = message.name

    local f = bot[name]
    if f then
        f(bot, table_unpack(message.args))
    else
        ERROR_MSG("can't find %s func !!!", name)
    end
end

return _M
