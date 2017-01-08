--------------------------------------------------------------------------------
-- type.lua
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local ipairs = ipairs

local DEBUG_MSG = tengine.DEBUG_MSG

local _M = {}

local ENTITY_TYPE_NONE = 0

local types = {}

function _M.register(name)
	if _M.type(name) == ENTITY_TYPE_NONE then
		types[#types + 1] = name
		DEBUG_MSG("Type register " .. name .. " " .. #types)
	end
end

function _M.type(name)
	for i, _name in ipairs(types) do
		if name == _name then
			return i
		end
	end

	return ENTITY_TYPE_NONE
end

function _M.name(id)
	return types[id] or "unknown"
end

function _M.types()
	return types
end

return _M
