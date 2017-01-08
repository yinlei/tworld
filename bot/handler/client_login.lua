-------------------------------------------------------------------------------
-- client_login.lua
-------------------------------------------------------------------------------
local actor = tengine.actor
local ser = require "lib.ser"

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG

local client_login = require("packet.client_login")

local _M = {
    ID = client_login.ID,
}

function _M.handle(bot, message)
    -- 客户端登陆验证
    tengine.p("client_login")
    tengine.p(message)
end

return _M
