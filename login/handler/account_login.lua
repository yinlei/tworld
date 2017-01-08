-------------------------------------------------------------------------------
-- 登录协议
-- 1. client-->login
-------------------------------------------------------------------------------
local tostring = tostring

local actor = tengine.actor
local ser = require "lib.ser"

local rpc = require("lib.entity").rpc

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local account_login = require("packet.account_login")

local db = require "db"

local _M = {
    ID = account_login.ID,
}

function _M.handle(agent, message)
    local account = message.username

    if db.check_account(account) == 0 then
        local _global = actor.sync("global")
        local ok, ret = _global.create_base_from_name(1, "Account",
            account, actor.self())
        if not ok or not ret then
            ERROR_MSG("create account entity failed !!!")
            return
        end

        -- 获取登录token
        local _account = rpc(ret)
        local ok, key = _account.client_key(ret.id)
        if not ok or not key then
            ERROR_MSG("can't get client key !!!")
            -- TODO
            return
        end

        p(key)

        agent:send(account_login, 0, tostring(key[1]), key[2])
        INFO_MSG("create Account entity success ...")

        return
    end
    
    ERROR_MSG("check account failed !!!")
    -- TOOD
end

return _M
