--------------------------------------------------------------------------------
-- client.lua
--------------------------------------------------------------------------------
local entity_rpc = require("packet.entity_rpc")

local _M = {}

function _M.new(agent, define, id)
    local instance = {agent = agent, define = define, id = id}

    setmetatable(instance, {__index = function(t, key)
        local agent = t.agent
        local def = t.define
        local id = t.id
        local func = key
        return function( ... )
            agent:send(entity_rpc, func, {...})
        end
    end})
    return instance
end

return _M
