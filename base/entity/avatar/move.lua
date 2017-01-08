-------------------------------------------------------------------------------
-- move.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local _M = require (_PACKAGE.."/avatar")

--- 移动
function _M:move(face, x, y, z)
	p("Avatar move", face, x, y, z)

    -- 直接转到逻辑服
	if self.cell then
       --self.cell.move(face, x, y, z)
	end
end
