--------------------------------------------------------------------------------
-- factory.lua
--------------------------------------------------------------------------------
local type = type
local table_unpack = table.unpack

local actor = tengine.actor

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local manager = require("lib.entity").manager

local _M = {}

function _M.create_base(...)
    local _entity = manager.create(...)
    if not _entity then
        ERROR_MSG("create base failed !!!")
		return nil
    end

    if type(_entity.init) == "function" then
        _entity:init()
    end

	return _entity
end

function _M.create_base_anywhere(name, ...)
	if type(name) ~= "string" then
		return nil
	end

    local global = actor.sync("global")

    return global.create_base_anywhere(name, ...)
end

function _M.create_base_from_dbid(type, db_id, callback)
	p("create_base_from_dbid", type, db_id, callback)

	actor.callback("db",
		function(type, db_id, ret)
			p("Factory.create_base_from_dbid callback", type, db_id, ret)

			local entity

			if ret then
				entity = Factory.create_base_from_db_data(type, nil, db_id, ret)
			end

			if callback then
				callback(entity)
			end
		end, "select_entity", type, db_id)
end

function _M.create_base_with_data(type, id, data, ...)
	p({"Factory.create_base_with_data", type, id, data})

	local entity = manager.create(type, id)

	entity:update_property(data)

    entity:init(...)

	return entity
end

function _M.create_base_from_db_data(type, id, db_id, data, ...)
	p("Factory.create_base_from_db_data ", type, id, db_id, data)

	local entity = manager.create(type, id)

	if not entity then
		error("create entity failed !!!")
	end

	entity:set_dbid(db_id)
	entity:update_property(data)

    entity:init(...)

	return entity
end

return _M
