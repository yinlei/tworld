-------------------------------------------------------------------------------
-- 角色
-------------------------------------------------------------------------------
local unpack = unpack or table.unpack

local actor = tengine.actor
local bt = tengine.behaviourtree

local character = bt.Task:new()

function character:run(args)
    local agent, packet, message = unpack(args)
    local succ, ret = actor.call("login", "character", agent.account)

    if succ then
        agent:send(packet, ret)
    end
end

return character
