-------------------------------------------------------------------------------\
-- attached.lua
-------------------------------------------------------------------------------
local actor = tengine.actor
local ser = require "lib.ser"

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG

local attached = require("packet.attached")

local _M = {
    ID = attached.ID,
}

function _M.handle(bot, message)
    -- 客户端登陆验证
    INFO_MSG("attached to entity %s", message.key)
    if message.key == "Avatar" then
        INFO_MSG("Avatar start move ...")
        bot:randmove()
    end
end

return _M
