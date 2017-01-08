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

--- 物品操作集

InventorySystem.static.ITEM_OPERATION_ADD = 1     -- 增加
InventorySystem.static.ITEM_OPERATION_UPDATE = 2  -- 更新
InventorySystem.static.ITEM_OPERATION_DELETE = 3  -- 删除
