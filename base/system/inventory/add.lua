-------------------------------------------------------------------------------
-- 仓库系统
-------------------------------------------------------------------------------
local _PACKAGE      = (...):match("^(.+)[%./][^%./]+") or ""

local ERROR = tengine.ERROR_MSG
local INFO = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local p = tengine.p

--------------------------------------------------------------------------------
local InventorySystem = require(_PACKAGE.."/inventory")

-- 配置文件
local ItemData = require "data.item"

--------------------------------------------------------------------------------
local function less(a, b)
    p(a, b)
    if a.type == b.type then
        return a.count < b.count
    else
        return a.type > b.type
    end
end

--- 添加可以叠加的道具
function InventorySystem:add_stackable_item(item, bag, max_stack)
    local free_count = self:get_free_count(bag)

    if not self:check_space(item.type, item.count) then
        return false
    end

    local count = item.count
    local items = self:get_bag_items(bag)

    table.sort(items, less)

    for _, v in pairs(items) do
        if v.type == item.type then
            local left_count = max_stack - item.count
            if count > left_count then
                v.count = max_stack
                count = count - left_count
                self:update_to_client(bag, InventorySystem.ITEM_OPERATION_ADD, v)
            else
                v.count = v.count + count
                count = 0
                self:update_to_client(bag, InventorySystem.ITEM_OPERATION_ADD, v)
            end
        end
    end

    if count > 0 then
        local real_count = math.ceil(count/max_stack)
        for i = 1, real_count do
            local _item = self:create_new_item()

            _item.id = self:get_uid()
            _item.slots = {}
            _item.ext = {}
            _item.index = self:get_index(bag)

            if count > max_stack then
                _item.count = max_stack
                count = count - max_stack
            else
                _item.count = count
                count = 0
            end

            table.insert(items, _item)
            self:update_to_client(bag, InventorySystem.ITEM_OPERATION_ADD, _item)
        end
    end

    return true
end

--- 添加不可叠加的道具
function InventorySystem:add_unstackable_item(item, bag)
    local avatar = self:avatar()

    local free_count = self:get_free_count(bag)

    if free_count < item.count then
        return false
    end

    local items = self:get_items(bag)

    for i = 1, item.count do
        local _item = self:create_new_item()
        _item.id = self:get_uid()
        _item.slots = {}
        _item.ext = {}
        _item.index = self:get_index(bag)
        _item.count = 1
        table.insert(items._item)
        self:update_to_client(bag, op, _item)
    end

    return true
end


--- 添加新道具到背包
function InventorySystem:add_item(type, count)
    local item = self:create_new_item()

    item.type = type
    item.count = count

    local item_data = ItemData[type]
    if not item_data then
        ERROR("InventorySystem add_item  type = %d, count = %d item_data is nil !!!", type, count)
        return false
    end

    local bag = self:get_bag_type(item_data)

    if self:check_stackable(item_data) then
        return self:add_stackable_item(item, bag, item_data.stack)
    else
        return self:add_unstackable_item(item, bag)
    end
end

