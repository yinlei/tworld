-------------------------------------------------------------------------------
-- helper.lua
-------------------------------------------------------------------------------
local _PACKAGE      = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local _M = require (_PACKAGE.."/account")

-- 随机名字
function _M:random_name(vocation)

end

-- 设置平台账号
function _M:set_plat_account(plat_account)
	DEBUG("Account.SetPlatAccountReq plat_account = " .. plat_account)
	self.plat_account = plat_account
end

-- 检测是否被禁止
function _M:check_forbidden(holder)
	holder = holder or {}

	local forbidden_time = holder[self.name] or -1

	local current = os.time()

	if forbidden_time == 0 then
		return true
	else
		return current < forbidden_time
	end

	return false
end

-- ip是否禁止登录
function _M:is_ip_forbidden()
	return self:check_forbidden(Global.getBaseData("forbidden_ips") or {})
end

-- 账号是否禁止登录
function _M:is_account_forbidden()
	return self:check_forbidden(Global.getBaseData("forbidden_accounts") or {})
end

