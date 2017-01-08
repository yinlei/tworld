-------------------------------------------------------------------------------
-- version.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local ERROR_MSG = tengine.ERROR_MSG

local _M = require (_PACKAGE.."/account")

-- 版本检测
function _M:check_version(v)
    ERROR_MSG("check_version")
end
