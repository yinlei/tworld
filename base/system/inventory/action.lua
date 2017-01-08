-------------------------------------------------------------------------------
-- 仓库系统 生成道具ID
-------------------------------------------------------------------------------
local _PACKAGE      = (...):match("^(.+)[%./][^%./]+") or ""

local ERROR = tengine.ERROR_MSG
local INFO = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local p = tengine.p

local InventorySystem = require(_PACKAGE.."/inventory")

