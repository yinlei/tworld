-------------------------------------------------------------------------------
-- client_login.lua
-------------------------------------------------------------------------------
local actor = tengine.actor
local ser = require "lib.ser"

local manager = require("lib.entity").manager
local rpc = require("lib.entity").rpc

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG

local client_login = require("packet.client_login")

local key = require("base.core").key

local _M = {
    ID = client_login.ID,
}

function _M.handle(agent, message)
    -- 客户端登陆验证
    local _key = key.get(tonumber(message.key))

    if not _key then
        ERROR_MSG("can't find key !!!")
        agent:send(client_login, 1)
        return
    end

    local entity = manager.entity(_key[4])
    if not entity then
        INFO_MSG("can't find entity %d", _key[4])
        --agent:send(_M, -1, 0, 0, "", 0, 0, 0)
        return
    end

    agent:attach(entity)

    entity:give_client(agent)

end

return _M
