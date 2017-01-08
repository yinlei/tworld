-------------------------------------------------------------------------------
-- 仓库系统 判断
-------------------------------------------------------------------------------
local _PACKAGE      = (...):match("^(.+)[%./][^%./]+") or ""

local ERROR = tengine.ERROR_MSG
local INFO = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local p = tengine.p

local InventorySystem = require(_PACKAGE.."/inventory")

-- 配置文件
local ItemData = require "data.item"

--- 背包是否已满
function InventorySystem:check_full(bag)
    return self:get_free_count(bag) ~= 0
end

--- 检查道具是否可以叠加
function InventorySystem:check_stackable(item_data)
    if not item_data.stack or item_data.stack == -1 then
        return false
    end

    return true
end

--- 检查同类型数量的道具是否有足够的空间
function InventorySystem:check_space(type, count)
    local avatar = self:avatar()
    local item_data = ItemData[type]

    if not item_data then
        return false
    end

    local bag = self:get_bag_type(item_data)

    local is_stack = self:check_stackable(item_data)

    local free_count = self:get_free_count(bag)

    if free_count > count then
        return true
    end

    local _count = 0

    local max_stack = item_data.stack or 1

    if is_stack then
        local items = self:get_items(bag)
        for _, v in pairs(items) do
            if v.type == type then
                _count = _count + (max_stack-v.count)
            end
        end
    end

    if _count >= count then
        return true
    end

    _count = _count + max_stack * free_count

    if _count >= count then
        return true
    end

    return false

end

--- 检查不同类型数量的道具是否有足够的空间
-- item = {id, count}
function InventorySystem:check_spaces(items)
    for _, v in ipairs(items) do
        if not self:check_space(v[1], v[2]) then
            return false
        end
    end

    return true
end


-- 检查是否有足够的指定道具
function InventorySystem:check_enough_items(type, count)
    local item_data = ItemData[type]
    if not item_data then
        return false
    end

    local bag = self:get_bag_type(item_data)
    local items = self:get_items(bag)

    local _count = 0

    for k, v in pairs(items) do
    end
    if v.type == type then
        _count = _count + v.count

        if _count >= count then
            return true
        end
    end

    return false
end
