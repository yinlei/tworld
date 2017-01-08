-------------------------------------------------------------------------------
-- 仓库系统 删除物品
-------------------------------------------------------------------------------
local _PACKAGE      = (...):match("^(.+)[%./][^%./]+") or ""

local ERROR = tengine.ERROR_MSG
local INFO = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local p = tengine.p

-- 配置文件
local ItemData = require "data.item"

--------------------------------------------------------------------------------
local InventorySystem = require(_PACKAGE.."/inventory")

--- 真正的删除道具
function InventorySystem:remove_items(items, bag, type, count)

end

--- 删除背包中指定类型和数量的物品
function InventorySystem:delete_item(type, count)

    local item_data = ItemData[type]
    if not item_data then
        return false
    end

    local bag = self:get_bag_type(item_data)
    local items = self:get_bag_items(bag)

    local enough = self:check_enough_items(type, count)
    if not enough then
        return false
    end

    self:remove_items(items, bag, type, count)
end
