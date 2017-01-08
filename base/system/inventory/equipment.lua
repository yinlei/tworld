-------------------------------------------------------------------------------
-- 仓库系统 装备
-------------------------------------------------------------------------------
local _PACKAGE      = (...):match("^(.+)[%./][^%./]+") or ""

local ERROR = tengine.ERROR_MSG
local INFO = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local p = tengine.p

local InventorySystem = require(_PACKAGE.."/inventory")

-- 配置文件
local ItemData = require "data.item"

--- 添加装备到角色身上
function InventorySystem:add_equipment(type, index)
    local avatar = self:avatar()

    local item = self:create_new_item()

    item.type = type
    item.count = 1
    item.id = self:get_uid()

    local target = self:get_item(index, BAG_TYPE_EQUIPMENT)
    if not  target then
        item.index = index
    else
        -- TODO delete
        return false
    end

    local items = self:get_items(BAG_TYPE_EQUIPMENT)
    table.insert(items, item)

    return true
end

--- 初始化角色身上的装备
function InventorySystem:init_equipment_items(items)
    p("InventorySystem init_equipment_items", items)

    local avatar = self:avatar()

    for id, count in pairs(items) do
        local item_data = ItemData[id]
        if not item_data  then
            return false
        end

        if item_data.vocation ~= avatar.vocation then
            return false
        end

        for i = 1, count do
            if not self:add_equipment(id, item_data.type) then
                return false
            end
        end
    end
end

