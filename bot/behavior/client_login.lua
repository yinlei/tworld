-------------------------------------------------------------------------------
-- 客户端登录验证
-------------------------------------------------------------------------------
local unpack = unpack or table.unpack

local actor = tengine.actor
local bt = tengine.behaviourtree

local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local client_login  = require "packet.client_login"

local _M = bt.Task:new()

function _M:start(args)
    tengine.p("client_login", #args)
    local bot = args[1]
    tengine.p("bot.key = ",  bot.key)
    tengine.p("bot account ", bot.account)
    bot:send(client_login, bot.key)
end

function _M:run(args)

    self:running()
    -- if #args == 1 then
    --     self:running()
    -- else
    --     local bot, packet, message = unpack(args)

    -- end

end

function _M:finish()
    DEBUG_MSG("client login finish ...")
end

return _M
