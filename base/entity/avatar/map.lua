-------------------------------------------------------------------------------
-- map.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local _M = require (_PACKAGE.."/avatar")

--- 切线
function _M:select_map_resp(map_id, line_id, space_base_service, space_cell_service, dbid, params)
	p("Avatar select_map_resp", map_id, line_id, space_base_service, space_cell_service, dbid, params)

	self:set_space_loader(space_base_service)
	p("self.scene_id ", self.scene_id, "self.imap_id", self.imap_id)

	p("self.cell", self.cell)

	-- 如果是本地图传送
	if map_id == self.scene_id and line_id == self.imap_id then
		self.cell.TelportLocally(0, 0)
	else
		if self.cell.service == space_cell_service.service  then
			self:TelportSameCell(space_cell_service.id, map_id, 0, 0)
		else
			self:TeleportRemotely(space_base_service, map_id, line_id, 0, 0)
		end
	end

end