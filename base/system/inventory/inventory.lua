-------------------------------------------------------------------------------
-- 仓库系统
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local table_length = table.length

local ERROR = tengine.ERROR_MSG
local INFO = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local p = tengine.p

local class = require "lib.middleclass"

local global = require("base.core").global

local System = require("base.system.system")

-- 配置文件
local RoleData = require "data.role"
local ItemData = require "data.item"

-- 背包类型配置
local BagType = require "data.bag"

-- 物品品质类型
local ItemQuality = require "data.item_quality"

-- 身上装备格子
local EquipmentIndex = require "data.equipment_index"


--------------------------------------------------------------------------------
local InventorySystem = class("InventorySystem", System)


function InventorySystem:initialize(owner)
    System.initialize(self, owner)

    self.uid = os.time()
end

function InventorySystem:get_items()
    local all = {}

    all[BagType.BAG_TYPE_GENERAL] = self:get_bag_items(BagType.BAG_TYPE_GENERAL)
    all[BagType.BAG_TYPE_EQUIPMENT] = self:get_bag_items(BagType.BAG_TYPE_EQUIPMENT)

    return all
end

-- 获取背包的所有物品
function InventorySystem:get_bag_items(bag)
    local avatar = self:avatar()

    if bag == BagType.BAG_TYPE_EQUIPMENT then
        return avatar.equipments
    elseif bag == BagType.BAG_TYPE_GENERAL then
        return avatar.items
    end

    return {}
end

--- 通过索引获取指定背包的物品
function InventorySystem:get_item(index, bag)
    local items = self:get_bag_items(bag)

    for _, v in pairs(items) do
        if v.index == index then
            return v, k
        end
    end
end

--- 获取背包空间
function InventorySystem:get_cap_count(bag)
    if bag == BagType.BAG_TYPE_EQUIPMENT then
        return 10
    elseif bag == BagType.BAG_TYPE_GENERAL then
        return 100
    end

    return 0
end

--- 获取背包空闲数
function InventorySystem:get_free_count(bag)
    local cap_count = self:get_cap_count(bag)
    local items = self:get_bag_items(bag)

    return cap_count - table_length(items)
end

--- 获取背包使用数
function InventorySystem:get_used_count(bag)
    local items = self:get_bag_items(bag)

    return table_length(items)
end

--- 获取物品所属的背包类型
function InventorySystem:get_bag_type(item_data)
    return BagType.BAG_TYPE_GENERAL
end

--- 获取背包空格子索引
function InventorySystem:get_index(bag)
    local items = self:get_bag_items(bag)

    local used_index = {}

    for k, v in pairs(items) do
        local index = v.index
        used_index[index] = 1
    end

    local i = 1

    for k, v in ipairs(used_index) do
        i = i + 1
    end

    if i > self:get_cap_count(bag) then
        return 0
    end

    return i
end

return InventorySystem
