-------------------------------------------------------------------------------
-- 仓库系统 生成道具ID
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


--- 创建一个新的道具
function InventorySystem:create_new_item()
    local item = {}
    item.id = self:get_uid()
    item.type = 0
    item.index = 0
    item.bind_type = 0
    item.count = 0
    item.slots = {}
    item.ext = {}
    return item
end

