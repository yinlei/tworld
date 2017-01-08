--------------------------------------------------------------------------------
-- usermanager.lua
--------------------------------------------------------------------------------
local INFO_MSG = tengine.INFO_MSG

local class = require("lib.middleclass")

local super = require "base.entity.BaseEntity"

local _M = class("UserManager", super)

function _M:initialize( ... )
	super.initialize(self, ...)
end

return _M
