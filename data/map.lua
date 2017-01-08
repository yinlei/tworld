-------------------------------------------------------------------------------
-- 地图配置
-------------------------------------------------------------------------------
local INFO_MSG = tengine.INFO_MSG

local config = import ".config"

INFO_MSG("load Map.xml ...")

local datas = config.Load("Map.xml")

local maps = {}

for id, child in ipairs(datas.RECORDS:children()) do
	local item  = {}
	for _, name in ipairs(child:properties()) do
		item[name.name] = child["@" .. name.name]
	end

	maps[tonumber(item.ID)] = item
end

INFO_MSG("load Map.xml ok ...")

return maps
