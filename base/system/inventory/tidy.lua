-------------------------------------------------------------------------------
-- 仓库系统 整理仓库
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


local function great(a, b)
    if  a.type == b.type then
        if a.count == b.count then
            return a.index < b.index
        else
            a.count > b.count
        end
    else
        a.type > b.type
    end
end

--- 整理背包
function InventorySystem:tidy_bag(bag)
    local items = self:get_items(bag)

    table.sort(items, great)

    local length = table.length(items)
    return true
end

--- 整理
function InventorySystem:tidy()
    local avatar = self:avatar()

    if  self:tidy_bag(BAG_TYPE_GENERAL) then
        self:
    end
end
