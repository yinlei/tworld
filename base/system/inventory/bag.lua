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

--[[
    背包类型
]]--
local BAG_TYPE_GENERAL = 1      -- 普通背包
local BAG_TYPE_EQUIPMENT = 2    -- 装备背包


--- 背包类型

InventorySystem.static.BAG_TYPE_GENERAL = BAG_TYPE_GENERAL
InventorySystem.static.BAG_TYPE_EQUIPMENT = BAG_TYPE_EQUIPMENT

--- 获取的所有背包数据

function InventorySystem:get_all_bag()

end
