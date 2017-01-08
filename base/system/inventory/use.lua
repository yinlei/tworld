-------------------------------------------------------------------------------
-- 仓库系统 使用物品
-------------------------------------------------------------------------------
local _PACKAGE      = (...):match("^(.+)[%./][^%./]+") or ""

local ERROR = tengine.ERROR_MSG
local INFO = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local p = tengine.p

local InventorySystem = require(.."/inventory")

-- 配置文件
local ItemData = require "data.item"

--- 使用物品
function InventorySystem:use_item(id, index, count)
    local avatar = self.owner()

    local item = self:get_item(index, BAG_TYPE_GENERAL)

    if not item then
        return -1, 0
    end

    local item_data = ItemData[item.type]

    if not item_data then
        return
    end

    local effect_id = item_data.effect_id

    if not effect_id then
        return
    end

    return
end
