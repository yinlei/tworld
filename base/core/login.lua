--------------------------------------------------------------------------------
-- login.lua
--------------------------------------------------------------------------------
local actor = tengine.actor

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local function set_login(flag)
	actor.rpc("login", "login_flag", flag or 0)
end

local function forbid_login(account, time)
	actor.rpc("login", "forbid_login", account, time)
end

local function forbidLoginByIp(ip, time)
	actor.rpc("login", "forbid_login_by_ip", ip, time)
end

local function setBaseData(key, value)
	actor.rpc("master", "set_base_data", key, value)
end
