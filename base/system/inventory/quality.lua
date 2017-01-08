-------------------------------------------------------------------------------
-- 仓库系统 生成道具ID
-------------------------------------------------------------------------------
local _PACKAGE      = (...):match("^(.+)[%./][^%./]+") or ""

local ERROR = tengine.ERROR_MSG
local INFO = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local p = tengine.p

local InventorySystem = require(_PACKAGE.."/inventory")


--[[
    品质类型
]]--
local ITEM_QUALITY_WHITE = 1     -- 白色
local ITEM_QUALITY_GREEN = 2     -- 绿色
local ITEM_QUALITY_BLUE = 3      -- 蓝色
local ITEM_QUALITY_PURPLE = 4    -- 紫色
local ITEM_QUALITY_ORANGE = 5    -- 橙色

InventorySystem.static.ITEM_QUALITY_WHITE = ITEM_QUALITY_WHITE
InventorySystem.static.ITEM_QUALITY_GREEN = ITEM_QUALITY_GREEN
InventorySystem.static.ITEM_QUALITY_BLUE = ITEM_QUALITY_BLUE
InventorySystem.static.ITEM_QUALITY_PURPLE = ITEM_QUALITY_PURPLE
InventorySystem.static.ITEM_QUALITY_ORANGE = ITEM_QUALITY_ORANGE
