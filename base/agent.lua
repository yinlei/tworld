--------------------------------------------------------------------------------
-- agent.lua
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local string = string

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local packets = require("packet")

--local behavior = require("base.behavior")
local handlers = require("base.handler")

local agents = {}

local handler = function(self, data, size)
    local id, pos = string.unpack('>H', data)

    local packet = packets[id]
    if not packet then
        ERROR_MSG("can't find packet %d", id)
        return
    end

    --tengine.p("agent handler", data, size)
    --[[
    local message = packet.decode(data:sub(pos, size))

    self.behavior:run({self, packet, message})
    --]]
    local message = packet.s_decode(data:sub(pos, size))

    local handler = handlers[id]
    if not handler then
        ERROR_MSG("can't find handler %d", id)
        return
    end

    local succ, ret = pcall(handler.handle, self, message)
    if not succ then
        ERROR_MSG(ret)
    end
end

local send = function(self, packet, ...)
    if self.owner then
        local buff = string.pack('>H', packet.ID) .. packet.s_encode(...)
        self.owner:send(self.session, buff, string.len(buff))
    end
end

local lost = function(self, session, err)
    INFO_MSG("agent lost err %s", err)
    agents[session] = nil
end

local attach = function(self, entity)
    self.entity = entity
end

local methods = {
    handler = handler,
    send = send,
    lost = lost,
    attach = attach,
    test = test
}

local new = function(owner, session)
    local self = setmetatable({}, {__index=methods})
    self.owner = owner
    self.session = session
    --self.behavior = behavior.new()
    agents[session] = self

    return self
end

local find = function(session)
    return agents[session]
end

return {
    new = new,
    find = find,
}
