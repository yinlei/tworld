-------------------------------------------------------------------------------
-- manager.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local table_remove = table.remove
local table_unpack = table.unpack

local p = tengine.p
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local INFO_MSG = tengine.INFO_MSG

local lshift = tengine.bit.lshift

local types = require(_PACKAGE .. "/type")

local _M = {}

local holder = {}

local classes = {}

local id_seed = lshift(__Service__, 24)

function _M.register(type, class)
	if not classes[type] then
		classes[type] = class
		types.register(type)
	end
end

function _M.seed_id(id)
	id_seed = lshift(id, 24)
end

function _M.class(type)
	return classes[type]
end

function _M.add(entity)
	holder[entity.id] = entity
end

function _M.entity(id)
	return holder[id]
end

function _M.del(entity)
	holder[entity.id] = nil
end

function _M.create(...)
	local args = {...}

	local name = args[1]

	if type(name) ~= "string" then
		name = types.name(name)
		if not name then
            ERROR_MSG("EntityManager create can't get %d type name !!!", name)
			return nil
		end
	end

	local type = types.type(name)

	if type == types.ENTITY_TYPE_NONE then
        ERROR_MSG("EntityManager create can't get type of %s !!!", name)
		return nil
	end

	table_remove(args, 1)

	local id = args[1] or 0
	if id <= 0 then
		id_seed = id_seed + 1
		id = id_seed
	end

	DEBUG_MSG("EntityManager ready to create id = " .. id .. " name = " .. name .. " type = " .. type)

	local class = _M.class(name)
	if not class then
        ERROR_MSG("EntityManager create can't find entity %s !!!", name)
		return nil
	end

	table_remove(args, 1)

    local success, ret = pcall(class.new, class, type, id, table_unpack(args))
    if not success then
        ERROR_MSG("EntityManager create failed !!! %s", ret)
        return nil
    end

    if not ret then
        ERROR_MSG("EntityManager create failed!!!")
        return nil
    end

    _M.add(ret)

	return ret
end

function _M.destory(id)
	local entity = holder[id]
	if entity then
		entity:on_destory()

		holder[id] = nil
	end
end

return _M
