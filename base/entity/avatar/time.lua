-------------------------------------------------------------------------------
-- time.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local _M = require (_PACKAGE.."/avatar")


--- 获取服务器时间
function _M:get_server_time(type)
    self.property.gold = self.gold + 1
    return 0
end

function _M:GetServerTimeReq(type)
    local r = self:get_server_time(type)
    if r then
        self.client.GetServerTimeResp(type, r)
    end
end
