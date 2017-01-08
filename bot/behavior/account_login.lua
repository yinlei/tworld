-------------------------------------------------------------------------------
-- 账号登录验证
-------------------------------------------------------------------------------
local unpack = unpack or table.unpack

local actor = tengine.actor
local bt = tengine.behaviourtree

local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local account_login  = require "packet.account_login"

local _M = bt.Task:new()

function _M:start(args)
    -- 登录
    local bot = args[1]
    bot:send(account_login, bot.version, bot.account)
end

function _M:run(args)
    tengine.p("account_login", #args)
    self:running()
    if #args == 1 then
        self:running()
    else
        local bot, packet, message = unpack(args)

        if message.result ~= 0 then
            self:fail()
            ERROR_MSG("account login failed !!!")
        else
            tengine.p("key = ", message)
            local address = message.address
            bot.key = message.key
            tengine.p("bot account ", bot.account, address)
            local ret = bot:connect(address)
            tengine.p("ret = ", ret)
            if ret then
                tengine.p("connect ed ", bot.key)
                self:success()
            else
                self:failed()
            end
        end
    end

end

function _M:finish()
    DEBUG_MSG("account login finish ...")
end

return _M
