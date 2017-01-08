-------------------------------------------------------------------------------
-- 仓库系统 出售道具
-------------------------------------------------------------------------------
local _PACKAGE      = (...):match("^(.+)[%./][^%./]+") or ""

local ERROR = tengine.ERROR_MSG
local INFO = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local p = tengine.p

local InventorySystem = require(_PACKAGE.."/inventory")

-- 配置文件
local ItemData = require "data.item"

--- 出售道具
function InventorySystem:sell_item()
end
