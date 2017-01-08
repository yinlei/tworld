-------------------------------------------------------------------------------
-- client.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local _M = require (_PACKAGE.."/avatar")

function _M:response(commnad, ...)
    if not self.client then
        ERROR_MSG("Avatar response client is nil !!!")
    end

    self.client[command](...)
end
