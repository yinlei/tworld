-------------------------------------------------------------------------------
-- spaceloader.lua
-------------------------------------------------------------------------------
local actor = tengine.actor

local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local class = require("lib.middleclass")

local rpc = require("lib.entity").rpc

local global = require("base.core").global

local super = require("base.entity.baseentity")

local _M = class("SpaceLoader", super)

function _M:init()
	DEBUG_MSG("SpaceLoader init")

	self:create_in_new_space()
end

function _M:create_in_new_space(...)
	p("SpaceLoader create_in_new_space ", self.type_name, self.service)

    local _global = actor.sync("global")

    local succ, ret = _global.create_cell_in_new_space(self.type_name, self.service, ...)
    if not succ then
        ERROR_MSG("SpaceLoader create_in_new_space failed !!!")
        return
    end

    DEBUG_MSG("global create_cell_in_new_space succ ...")

    local cell = rpc(ret)

    self:set_cell(cell)

    self:on_get_cell()

    p("SpaceLoader create_in_new_space end ...")
end

function _M:on_get_cell()
	local map_manager = global.object("MapManager")
	if map_manager then
		map_manager.on_map_loaded(self:get_id(), self.service, self.cell)
	else
        ERROR_MSG("can't find mapmanager !!!")
	end
end

function _M:set_map_id(service, scene_id, line, dbid, name, args)
	p("SpaceLoader set_map_id", scene_id, line, dbid, name, params)
    self.scene_id = scene_id
    self.line = line
	self.map_id = scene_id .. line

	-- 获取地图信息

	self.logic = nil

	local ok, ret = self.cell.set_map_id(service, scene_id, line, dbid, name, args)
    if not ok then
        ERROR_MSG("spaceloader cell set_map_id failed !!!")
    end

    return ret
end

function _M:create_cell_entity(service, x, y)
	p("SpaceLoader create_cell_entity", x, y)

	self.cell.create_cell_entity(service, x, y)
end

function _M:change_map_count(flag, count)
	p("SpaceLoader change_map_count", flag, count)
    local map_manager = global.object("MapManager")
    if map_manager then
        map_manager.change_map_count(flag, self.scene_id, self.line, count)
    end
end

return _M
