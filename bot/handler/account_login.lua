-------------------------------------------------------------------------------
-- accout_login.lua
-- login-->client
-------------------------------------------------------------------------------
local actor = tengine.actor
local ser = require "lib.ser"

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG

local account_login  = require "packet.account_login"

local client_login  = require "packet.client_login"

local _M = {
    ID = account_login.ID,
}

function _M.handle(bot, message)
    local account = message.username
    tengine.p("accoun_login handle", message)

    local address = message.address

    local key = message.key

    local ret = bot:connect(address)
    if ret then
        INFO_MSG("connect to base ok ...")
        bot:send(client_login, key)
    else
        ERROR_MSG("connect base faield !!!")
    end
end

return _M
