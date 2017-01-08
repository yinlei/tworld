--------------------------------------------------------------------------------
-- 物品配置
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

-- 装备
local equipments = require(_PACKAGE.."/item_equipment")
-- 物品
local generals = require(_PACKAGE.."/item_general")

-- 将所有物品合到一张表

local items = {}

for k, v in pairs(equipments) do
    items[k] = v
end

for k, v in pairs(generals) do
    items[k] = v
end

return items
