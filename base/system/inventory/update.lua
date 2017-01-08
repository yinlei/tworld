-------------------------------------------------------------------------------
-- 仓库系统 刷新客户端数据
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local ERROR = tengine.ERROR_MSG
local INFO = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local p = tengine.p

-- 配置文件
local RoleData = require "data.role"
local ItemData = require "data.item"

--------------------------------------------------------------------------------
local InventorySystem = require(_PACKAGE.."/inventory")

--- 构造客户端删除物品表
local function format_delete_item(bag, item)
    local t = {}
    table.insert(t, bag)
    table.insert(t, item.index-1)
    return t
end

--- 构造客户端新物品表
local function format_new_item(bag, item)
    local t = {}
    table.insert(t, item.id)
    table.insert(t, item.type)
    table.insert(t, bag)
    table.insert(t, item.index-1)
    table.insert(t, item.count)
    table.insert(t, item.bindtype)
    table.insert(t, item.slots)
    table.insert(t, item.ext)

    return t
end

--- 更新单个物品到客户端
function InventorySystem:update_to_client(bag, op, item)
    p("InventroySystem update_to_client ", bag, op, item)
    local avatar = self:avatar()

    local _item

    if op == InventorySystem.ITEM_OPERATION_ADD or
    op == InventorySystem.ITEM_OPERATION_UPDATE then
        _item = format_new_item(bag, item)
    end

    if op == InventorySystem.ITEM_OPERATION_DELETE then
        _item = format_delete_item(bag, item)
    end

    if _item then
        avatar:update_item(op, _item)
    end

    return true
end


--- 更新背包数据到客户端
function InventorySystem:update_bag_to_client(bag, items)
    local t = {}

    for k, v  in pairs(items) do
        table.insert(t, format_new_item(bag, v))
    end

    if not next(t) then
        return
    end

    local avatar = self:avatar()

    avatar:update_items(t)
end

--- 同步所有数据
function InventorySystem:update_all_to_client()
    local all = self:get_items()

    for bag, v in pairs(all) do
        self:update_bag_to_client(bag, v)
    end
end
