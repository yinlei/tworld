-------------------------------------------------------------------------------
-- global.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local actor = tengine.actor

local rpc = require("lib.entity").rpc

local ERROR_MSG = tengine.ERROR_MSG

local _M = {}

local globals = {}

function _M.add(type, object)
	globals[type] = rpc(object)
end

function _M.object(name)
	return globals[name]
end

function _M.call(name, f, ...)
	local m = globals[name]
	if m then
		m[f](...)
	else
        ERROR_MSG("can't find " .. name .. " function !!!")
	end
end

return _M
