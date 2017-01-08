-------------------------------------------------------------------------------
-- cell.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local LOG_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local cmsgpack = tengine.cmsgpack
--------------------------------------------------------------------------------
local CellState = {
    CELL_STATE_NONE       = 0,      -- no cell
    CELL_STATE_IN_CREATING = 1,     -- cell is  creating
    CELL_STATE_CREATED     = 2,     -- cell has created
    CELL_STATE_IN_DESTROYING = 3,   -- cell is destroying
}

local _M = require (_PACKAGE.."/baseentity")


function _M:set_cell(cell)
	self.cell = cell

	self.cell_state = CellState.CELL_STATE_CREATED
end

function _M:removeCell()
	self.cell = nil

	self.cell_state = CellState.CELL_STATE_NONE
end

function _M:cell()
	if self.cell_state ~= CellState.CELL_STATE_CREATED then
		return nil
	end

	return self.cell
end

--cell创建好的回调方法
function _M:on_get_cell()
    --Debug("BaseEntity.onGetCell", string.format("id=%d", self:getId()) )
end



function _M:create_cell_entity(space_base_service, x, y)
	p("BaseEntity create_cell_entity ", space_base_service, x, y)

    local props = self:pack_cell_property()

	actor.rpc(space_base_service.service, "create_cell_via_mycell", space_base_service.id, self.service, x, y, props)
end

