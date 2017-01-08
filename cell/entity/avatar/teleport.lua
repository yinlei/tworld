-------------------------------------------------------------------------------
-- teleport.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local _M = require (_PACKAGE.."/avatar")

local EntityManager = require("game/entity").Manager

function _M:EnterTeleportpointReq(target_scene_id)
	p("Avatar EnterTeleportpointReq ", target_scene_id)
end


function _M:TelportSameCell(space_loader_id, scene_id, x, y)
	p("Avatar TelportSameCell", space_loader_id, scene_id, x, y)

	local space_loader = EntityManager.entity(space_loader_id)

	if space_loader then
		self:teleport(space_loader:get_space_id(), x, y)
	else
		p("Avatar TelportSameCell error !!!")
	end
end

