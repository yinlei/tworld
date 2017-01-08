--------------------------------------------------------------------------------
-- destory.lua
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local EntityManager = require("lib.entity").manager

local _M = require (_PACKAGE.."/avatar")

-- 删除包括账号
function _M:delete_all()
	local account_id = self.account_id or 0
	if account_id > 0 then
		local account = EntityManager.entity(account_id)
		if account then
			-- 更新状态
		end
	end

	EntityManager.destory(account_id)
end

-- 删除自己
function _M:delete_self()
	local account_id = self.account_id or 0
	if account_id > 0 then
		local account = EntityManager.entity(account_id)
		if account then
			account:update_avatar_info(self)
		end
	end

	-- 通知cell
	if self.cell then
	end
end

