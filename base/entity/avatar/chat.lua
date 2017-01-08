-------------------------------------------------------------------------------
-- chat.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local string_len = string.len
local string_byte = string.byte
local string_sub = string.sub

local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

-- 永久禁言标识
local BANED_CHAT_FOREVER = -1

local _M = require (_PACKAGE.."/avatar")

--- 聊天
function _M:chat(channel, dbid, msg)
    if string_len(msg) > 1 and string_byte("@") == string_byte(msg) then
        -- GM
        local cmd = string_sub(msg, 2)
        -- 执行GM命令
        local ret = self:execute(cmd)

        return
    end

    if not self:can_chat() then
        return
    end

    -- 根据频道
end

--- 禁言
function _M:ban_chat(baned, date, reason)
    reason = reason or ""

    if baned == 1 then
        -- 禁言
        if date == 0 then
            self.baned_chat_time = BANED_CHAT_FOREVER
            -- TODO 通知客户端被永久禁言
            return
        else
            self.baned_chat_time = date
        end
    else
        -- 解禁
        self.baned_chat_time = 0
    end
end

--- 是否可以聊天
function _M:can_chat()
    if self.baned_chat_time ~= 0 then
        if self.baned_chat_time == BANED_CHAT_FOREVER then
            return false
        end

        if self.baned_chat_time <= os.time() then
            return false
        end
    end

    return true
end
