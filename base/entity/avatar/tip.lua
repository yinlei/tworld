-------------------------------------------------------------------------------
-- tip.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local _M = require (_PACKAGE.."/avatar")

--- 信息提示
function _M:show_text(type, text, ...)
    local client = self.client
    if client then
        client.show_text(type, string.format(text, ...))
    end
end

function _M:show_text_id(type, id, ...)
    local client = self.client
    if not client then
        ERROR("Avatar show_text_id client is nil !!!")
        return
    end
end
