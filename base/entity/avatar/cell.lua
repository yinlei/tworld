-------------------------------------------------------------------------------
-- cell.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local rpc = require("lib.entity").rpc

local _M = require (_PACKAGE.."/avatar")

-- cell上的角色创建好回调
function _M:on_get_cell(s)
	p("Avatar on_get_cell", s)
    local cell = rpc(s)

    self:set_cell(cell)

	-- self.client.on_get_cell("test")

    -- 同步属性到逻辑服
    self:process_base_property()

    -- 同步装备到逻辑服
    self.inventory_system:sync_equipment()

    -- TODO

    -- 通知逻辑同步属性到客户端
    self.cell.pack_property_to_client()
    p("Avatar on_get_cell end")
end

function _M:create_cell(space_base_service)
	if self.db_id == 0 then
		return
	end

    p("Avatar create_cell ", space_base_service)
	local space_entity = rpc(space_base_service)
	if space_entity then
		space_entity.create_cell_entity(self.service, self.map_x, self.map_y)
	end


	--self:create_cell_entity(space_base_service)
end

function _M:attached_cell(t)
    DEBUG_MSG("Avatar attached_cell")
    -- self.client.attached_cell(t)
end
