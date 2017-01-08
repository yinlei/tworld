-------------------------------------------------------------------------------
-- mapmanager
-------------------------------------------------------------------------------
local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p =  tengine.p

local class = require("lib.middleclass")

local rpc = require("lib.entity").rpc

local global = require("base.core").global
local factory = require("base.core").factory

local Data = require("data")
local Maps = Data.maps

local super = require("base.entity.baseentity")

local _M = class("MapManager", super)

local MAP_STATE_INIT = 0
local MAP_STATE_LOADED = 1
local MAP_STATE_LOADING = 2

function _M:init()
	INFO_MSG("mapmanager init")
	-- 地图总数
	self.map_count = 0

	-- 已加载地图数
	self.map_loaded_count = 0

	-- 状态
	self.state = MAP_STATE_INIT

	-- 所有地图
	self.map_pool = {}

	-- 空闲
	self.idle_special_map_pool = {}

	-- 使用的地图
	self.busy_special_map_pool = {}

	-- 分线信息
	self.space_loader_count = {}

	-- 全服总人数
	self.player_count = 0

	-- 初始化地图和分线信息
	for id, _ in pairs(Data.maps) do

		self.space_loader_count[id] = {}

		self.busy_special_map_pool[id] = {}
	end

	local succ = self:register_globally()

    if succ then
        self:on_registered()
    end
end

function _M:on_registered()
	INFO_MSG("mapmanager on_registered")

	self:load_all_space()
end

function _M:load_all_space()
	INFO_MSG("mapmanager load_all_space")

    self.map_count = 2

	for i = 1, self.map_count do
		factory.create_base_anywhere("SpaceLoader")
	end

    INFO_MSG("MapManager load_all_space end ...")
end

function _M:on_map_loaded(space_loader_id, space_base_service,
                                  space_cell_service)
    DEBUG_MSG("on_map_loaded")

	local map_loaded_count = self.map_loaded_count + 1

	local map_count = self.map_count

	self.map_loaded_count = map_loaded_count

	self.map_pool[space_loader_id] = {space_base_service, space_cell_service}

	self.idle_special_map_pool[space_loader_id] = 1

	if map_count == map_loaded_count then
		DEBUG_MSG("all space %d loaded !!!!!!!!!!!!!!", map_count)
		-- 全部转载完毕通知GameManager
		self.state = MAP_STATE_LOADED

		local game_manager = global.object("GameManager")
		if game_manager then
			game_manager.on_manager_loaded("MapManager")
		end

	end

end

function _M:get_idle_map(map_id, line)
    p({"MapManager get_idle_map", map_id, line})

	for k, _ in pairs(self.idle_special_map_pool) do
		if self.busy_special_map_pool[map_id][line] then
			return self.map_pool[self.busy_special_map_pool[map_id][line]]
		else
			self.busy_special_map_pool[map_id][line] = k
			self.idle_special_map_pool[k] = nil
			return self.map_pool[k]
		end
	end

  return nil
end

function _M:get_space_loader(map_id, line)
	local ids = self.busy_special_map_pool[map_id] or {}

	local space_loader_id = ids[line]
	if space_loader_id then
		return self.map_pool[space_loader_id]
	else
		ERROR_MSG("get_space_loader")
	end
end

function _M:select_map(map_id, line, dbid, name, params)
	DEBUG_MSG("mapmanager select_map")

	-- 获得地图信息
	local map_info = Maps[map_id]
	if not map_info then
        ERROR_MSG("can not find map_data %d", map_id)
		return
	end

	-- 选择地图分线
	local map_counts = self.space_loader_count[map_id]

	if not map_counts then
		ERROR_MSG("can't find map !!!")
		return
	end

	local max_line = 0

	for imap, count in pairs(map_counts) do
		if imap > max_line then
			max_line = imap
		end

		-- 如果分线人数没达到最大值
		if count  < 1000 then
			local space_loader = self:get_space_loader(map_id, imap)

			-- service_entity.select_map_resp(map_id, imap, space_loader[1], space_loader[2], dbid,
            --                                params)
			-- return {map_id, imap, space_loader}
            return space_loader
		end
	end

	-- 找不到分线信息就申请一个新的
	local target_line = 1
	for i = 1, max_line+1 do
		if not map_counts[i] then
			target_line = i
			break
		end
	end

	-- 从空闲中分配一个新的
	local space_loader = self:get_idle_map(map_id, target_line)

	if not space_loader then
		ERROR_MSG("can't find space_loader %d-%d!!!", map_id, target_line)
		return
	end

	local space_base_service = rpc(space_loader[1])

	local succ, ret = space_base_service.set_map_id(service, map_id, target_line, dbid, name,
                                                    params)
    if not succ then
        ERROR_MSG("space_base set_map_id failed !!!")
        return
    end

    self.space_loader_count[map_id][target_line] = 0

    p("return 2", ret)
    return ret
	-- 是否要扩展地图

end

function _M:change_map_count(flag, scene, line, count)
    if not scene or not line then
        ERROR_MSG("MapManager change_map_count args error!!!!")
        return
    end

    local map_counts = self.space_loader_count[scene]

    if not map_counts then
        ERROR_MSG("MapManager change_map_count cant find %d map_count", scene)
        return
    end

    if flag == 'add' then
        DEBUG_MSG("MapManager change_map_count add")
        map_counts[line] = map_counts[line] + count

        self.player_count = self.player_count + count

    elseif flag == 'sub' then
        map_counts[line] = map_counts[line] - count

        local player_count = self.player_count - count

        if player_count < 0 then
            player_count = 0
        end

        self.player_count = player_count
    else
        ERROR_MSG("MapManager change_map_count unknow flag %s", flag)
    end

end

return _M
