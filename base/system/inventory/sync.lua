-------------------------------------------------------------------------------
-- 仓库系统 同步装备
-------------------------------------------------------------------------------
local _PACKAGE      = (...):match("^(.+)[%./][^%./]+") or ""

local ERROR = tengine.ERROR_MSG
local INFO = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local p = tengine.p

--------------------------------------------------------------------------------
local InventorySystem = require(_PACKAGE.."/inventory")

--- 同步装备到逻辑服
function InventorySystem:sync_equipment()
    local avatar = self:avatar()

    local indexs = {}

    for _, v in ipairs(indexs) do
        local item = self:get_item(v, BAG_TYPE_EQUIPMENT)
        if not item then
            avatar.cell.sync_equipment(v, 0)
        else
            avatar.cell.sync_equipment(v, item.type)
        end
    end
end
