-------------------------------------------------------------------------------
-- name.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local rpc = require("lib.entity").rpc

local global = require("base.core").global

local _M = require(_PACKAGE.."/usermanager")

-- 检测名字是否可用
function _M:check_name(service, name, param, callback)
	DEBUG_MSG("UserManager check_name name = " .. name)

	local entity_service = rpc(service)
	if entity_service then
		if self.name_to_dbid[name] then
			entity_service[callback](param, 1)
		else
			entity_service[callback](param, 0)
		end
	end
end

-- 使用名字
function _M:user_name(account_name, avatar_name)
	DEBUG_MSG("UserManager username account_name = " .. account_name .. " avatar_name = " .. avatar_name)
end
