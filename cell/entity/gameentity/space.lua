-------------------------------------------------------------------------------
-- space.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local space = require("cell.space")

local _M = require (_PACKAGE.."/gameentity")

-- 设置空间id
function _M:set_space_id(id)
	self.space_id = id
end

-- 获取空间id
function _M:get_space_id()
	return self.space_id
end

--- 获得空间
function _M:get_space()
    return space.find(self.space_id)
end
