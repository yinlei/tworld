-------------------------------------------------------------------------------
-- spaceloader
-------------------------------------------------------------------------------
local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local class = require("lib.middleclass")
local rpc = require("lib.entity").Wrap

local super = require "cell.entity.gameentity"

local spaceloader = require "cell.space.spaceLoader"

local cell = require "cell"

local _M = class("SpaceLoader", super)

function _M:init()
	p("SpaceLoader init ")

	self.is_active = 0

	spaceloader.register(self)

	self.mailbox = self.service

	p("self.service")
end

-- 载入地图
function _M:load_map()
	p("SpaceLoader load_map", self.map_id)
	-- 怪物
	self.alive_monster = {}

end

-- 设置地图id
function _M:set_map_id(scene_id, line, dbid, name, params)
	p({"SpaceLoader set_map_id", scene_id, line, dbid, name, params})

	p({"self.space_id", self.space_id})

	local is_login_now = true

	self.map_id = scene_id
	self.imap_id = line
	self.map_type = 0

	self.logic = nil

    --[[
	if is_login_now then
		local service_entity = RpcWrap(service)

		if service_entity then
			service_entity.select_map_resp(scene_id, line, self.base, self.service, dbid, params)
		end
	end
    --]]

    -- 载入地图
	self:load_map()

    return {self.base, self.service}
end

function _M:create_cell_entity(service, x, y)
	p("SpaceLoader create_cell_entity", service, x, y)

	return cell.create_cell_via_mycell(self.id, service, x, y, {}, {})
end

-- 玩家进入空间
function _M:on_avatar_enter(avatar)
	p("SpaceLoader on_avatar_enter")

	self.base.change_map_count("add", 1)
end

--- 玩家离开
function _M:on_avatar_leave(avatar)
	p("SpaceLoader on_avatar_leave")
    self.base.change_map_count("sub", 1)
end

return _M 
