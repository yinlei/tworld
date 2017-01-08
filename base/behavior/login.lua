-------------------------------------------------------------------------------
-- 登录
-------------------------------------------------------------------------------
local unpack = unpack or table.unpack

local actor = tengine.actor
local bt = tengine.behaviourtree

local login = bt.Task:new()

function login:run(args)
    local agent, packet, message = unpack(args)
    local succ, ret = actor.call("login", packet.name(), __Service__, message)
    tengine.p(succ)
    tengine.p(ret)
    if succ and ret == 1 then
        self:success()
    else
        self:fail()
        agent:send(packet, 1, 1)
    end
end

return login
