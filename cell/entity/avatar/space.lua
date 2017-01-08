-------------------------------------------------------------------------------
-- space.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local spaceloader = require("cell.space.spaceloader")

local _M = require (_PACKAGE.."/avatar")

-- 进入空间
function _M:on_enter_space()
	p("Avatar on_enter_space")

	local space_loader = spaceloader.find(self:get_space_id())
	if not space_loader then
		return
	end
    p("space_loader", space_loader)

	-- 进入空间
	self.space_loader = space_loader
	space_loader:on_avatar_enter(self)

	p("self.map_id", self.space_loader.map_id)
    local x,y = self:get_xy()

	self.base.change_scene(self.space_loader.map_id, self.space_loader.imap_id, x, y)
end

-- 离开空间
function _M:on_leave_space()
	p("Avatar on_leave_space")
	-- 清楚buff

	self.space_loader:on_avatar_leave(self)

	self.space_loader = nil
end