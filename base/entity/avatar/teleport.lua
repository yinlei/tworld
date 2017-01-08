-------------------------------------------------------------------------------
-- teleport.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local global = require("base.core").global

local _M = require (_PACKAGE.."/avatar")

--- 传送
function _M:TeleportCell2Base(target_scene_id, target_x, target_y)
	if self.scene_id == target_scene_id then

		if self.cell then
			self.cell.TelportLocally(target_x, target_y)
		else
			assert(false, "cell is nil")
		end
	else
		--global.call("MapManager", "Teleport", self.base, self.cell, target_scene_id, target_x, target_y)
		global.call("MapManager", "SelectMapReq", self.service, target_scene_id, target_x, target_y)
	end
end

function _M:EnterTeleportpointReq(target_scene_id)
	p("Avatar EnterTeleportpointReq ", target_scene_id)
	self:TeleportCell2Base(target_scene_id, 0, 0)
end


function _M:TelportSameCell(space_loader_id, scene_id, x, y)
	self.cell.TelportSameCell(space_loader_id, scene_id, x, y)
end
