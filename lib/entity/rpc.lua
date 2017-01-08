--------------------------------------------------------------------------------
-- rpc.lua
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local pcall, assert, table_copy = pcall, assert, table.copy

local actor = tengine.actor

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local manager = require(_PACKAGE .. "/manager")

local _call_meta = {}

_call_meta.__index = function(t, key)
	local context = t
	local f = key
	return function(...)
		if context.service == actor.self() then
			local entity = manager.entity(context.id)
			if entity then
				local f = assert(entity[f])

                return pcall(f, entity, ...)
			else
				ERROR_MSG("cann't find entity !!!")
			end
		else
            local succ, ret =
				actor.call(context.service, "entity_call", f, context, ...)

            return succ, ret
		end
	end
end

_call_meta.__newindex = function(t, key, value)

end

return function(service)
	local _service = table_copy(service)
	return setmetatable(_service, _call_meta)
end
