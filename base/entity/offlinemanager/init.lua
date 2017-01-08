-------------------------------------------------------------------------------
-- offlinemanager
-------------------------------------------------------------------------------
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local class = require("lib.middleclass")

local global = require("base.core").global

local super = require "base.entity.baseentity"

local _M = class("OfflineManager", super)

function _M:init()
	local ret = self:register_globally()

	if not ret then
        ERROR_MSG("offlinemanager register globally failed !!!")
        return
	end

    self:on_registered()
end

function _M:on_registered()
	--global.call("GameManager", "on_manager_loaded", "OfflineManager")
end


function _M:on_destory()
	-- body
end

return _M
