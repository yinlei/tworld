-------------------------------------------------------------------------------
-- teleport.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local _M = require (_PACKAGE.."/gameentity")

--- 传送
function _M:teleport(space_id, x, y)
	if space_id then
		local space = self:get_space()

        if not space then
            ERROR_MSG("GameEntity teleport cant get space !!!")
            return
        end

		space:delete_entity(self)

		self:on_leave_space()

		-- 进入新场景

		local space = SpaceManager.space(space_id)

		p("teleport", space)

		if space then
			space:add_entity(self)
		end

		self:on_enter_space()

	else

	end
end



