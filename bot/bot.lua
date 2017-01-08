--------------------------------------------------------------------------------
-- bot.lua
--------------------------------------------------------------------------------
local string = string

local channel = tengine.channel
local timer = tengine.timer

--local behavior = require("bot.behavior")

local packets = require("packet")
local account_login  = require "packet.account_login"
local entity_rpc = require "packet.entity_rpc"

local handlers = require("bot.handler")

local ERROR_MSG = tengine.ERROR_MSG
local INFO_MSG=  tengine.INFO_MSG

local on_read = function(self, data, size)
    local id, pos = string.unpack('>H', data)

    local packet = packets[id]
    if not packet then
        ERROR_MSG("can't find packet %d", id)
        return
    end

    local message = packet.c_decode(data:sub(pos, size))

    local handler = handlers[id]
    if not handler then
        ERROR_MSG("can't find handler %d", id)
    else
        handler.handle(self, message)
    end
    -- self.behavior:run({self, packet, message})
end

local on_closed = function(self, err)
    INFO_MSG("closed !!!")
    self.channel  = nil
end

local connected = function(self)
    return self.channel ~= nil
end

local connect = function(self, address)
    if self.channel then
        self.channel:close()
    end

    local function _on_read(data, size)
        self:on_read(data, size)
    end

    local function _on_closed(err)
        self:on_closed(err)
    end

    self.channel = channel.connect(address, _on_read, _on_closed)
    return self:connected()
end

local disconnect = function(self)
    if self.channel then
        self.channel:close()
        self.channel = nil
    end
end

local send = function(self, packet, ...)
    if self.channel then
        local buff = string.pack('>H', packet.ID) .. packet.c_encode(...)
        self.channel:send(buff, string.len(buff))
    end
end

local call = function(self, name, ...)
    self:send(entity_rpc, name, {...})
end

local start = function(self, address)
    if not self:connect(address) then
        ERROR_MSG("bot start failed !!!")
        return
    end

    -- local function _account_login()
    --     self:send(account_login, self.version, self.account)

    --     timer.callback(1000, _account_login)
    -- end
    -- -- self.behavior:run({self})
    self:send(account_login, self.version, self.account)

    --timer.callback(1000, _account_login)
end

local move =  function(self, face, x, y, z)
    self:call("move", face, x, y, z)
end

local randmove = function(self)

    local function _random()
        local face = math.random(1, 360)
        local x = math.random(1, 100)
        local y = math.random(1, 100)
        INFO_MSG("%s move to %d %d %d %d", self.account, face, x, y, 0)
        self:move(face, x, y, 0)
        if self:connected() then
            timer.callback(200, _random)
        end
    end

    timer.callback(200, _random)
end

local on_login = function(self, ret)
    if ret == 0 then
        INFO_MSG("login success !!!")
    end
end

local methods = {
    on_read = on_read,
    on_closed = on_closed,
    connect = connect,
    connected = connected,

    send = send,
    start = start,
    call = call,

    move = move,
    randmove = randmove,

    on_login = on_login,
}

local new = function(account, version)
    local self = setmetatable({}, {__index = methods})

    --self.behavior = behavior.new()

    self.account = account

    self.version = version or 0

    math.newrandomseed()

    return self
end

return {
    new = new
}
