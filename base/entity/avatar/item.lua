-------------------------------------------------------------------------------
-- item.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local string_len = string.len
local string_byte = string.byte
local string_sub = string.sub

local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local _M = require (_PACKAGE.."/avatar")

--- 创建角色初始化物品
function _M:init_items_for_avatar(vocation, dbid)
    local vocation = vocation or self.vocation
    local dbid = dbid or self.dbid

    local inventory = self.inventory_system
    if inventory then
       inventory:init_items_for_avatar(vocation, dbid)
    end
end

--- 更新物品数据给客户端
function _M:update_item(op, item)
    if self.inventory_system then
        if self.has_client then
            p("Avatar update_item ", op, item)
            self.client.UpdateItem(op, item)
        end
    end
end

--- 更新批量物品数据给客户端
function _M:update_items(items)
    if self.inventory_system then
        if self.has_client() then
            self.client.UpdateItems(items)
        end
    end
end

---  整理仓库
function _M:tidy()
    local inventory = self.inventory_system
    if inventory then
        inventory:tidy()
    end
end

--- 使用物品
function _M:use_item(id, index, count)
    if not self.inventory_system then
        return
    end

end

--- 添加道具
function _M:add_item(id, count, reason)
    p("Avatar add_item", id, count, reason)
    if not self.inventory_system then
        return
    end

    local ret = self.inventory_system:add_item(id, count)

    if ret then

    end
end

--- 删除道具
function _M:delete_item(id, count, reason)
    if not self.inventory_system then
        return
    end

    local ret = self.inventory_system:delete_item(id, count)

    if ret then
    end
end

--- 卖掉道具
function _M:sell_item(id, index, type, count)
    local inventory = self.inventory_system
    if not inventory then
        return
    end

    local ret = inventory:sell_item(id, index+1, type, count)
    return ret
end
