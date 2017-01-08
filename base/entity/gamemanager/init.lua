-------------------------------------------------------------------------------
-- gamemanager
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p  = tengine.p

local class = require("lib.middleclass")

local global = require("base.core").global
local factory = require("base.core").factory

local super = require("base.entity.baseentity")

local _M = class("GameManager", super)

function _M:on_registered()

	DEBUG_MSG("gamemanger on_registered")

    self.need_init = {}

	local ok, ret = factory.create_base_anywhere("OfflineManager")

	if not ok or ret ~= 0 then
		ERROR_MSG("create offlinemanager failed !!!")
		return
	end

	INFO_MSG("create offlinemanager ok ...")

	local ok, ret = factory.create_base_anywhere("MapManager")

	if not ok or ret ~= 0 then
		ERROR_MSG("create mapmanager failed !!!")
		return
    end

    self.need_init["MapManager"] = 1

	INFO_MSG("create mapmanager ok ...")

	local ok, ret = factory.create_base_anywhere("UserManager")
	if not ok or ret ~= 0 then
		ERROR_MSG("craete usermanager failed !!!")
		return
    end

    self.need_init["UserManager"] = 1

	INFO_MSG("create usermanager ok ...")

	-- 邮件
	-- 工会
	-- 初始化
	--self:init_manager()
end

function _M:init_manager()
    p("gamemanager init_manager")

	for name, _ in pairs(self.need_init) do
        p("ssssssssssss")
		local m = global.object(name)
		if m then
			--m.Init()
		else
			--ERROR("cant find " .. name .. "globalBase...")
		end
	end

	-- TODO
end

function _M:on_manager_inited(name)
	DEBUG_MSG("GameManager:on_manager_inited %s", name)

	self.need_init[name] = nil

    -- 所有都初始化完成就可以登陆了
	if table.length(self.need_init) == 0 then
        INFO_MSG("all manager init ...")
	end
end

function _M:on_destory()
	DEBUG_MSG("GameManager:on_destory")
end

return _M
