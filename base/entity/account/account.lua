--------------------------------------------------------------------------------
-- account.lua
--------------------------------------------------------------------------------
local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local class = require "lib.middleclass"

local manager = require("lib.entity").manager

local super = require "base.entity.baseentity"

local _M = class("Account", super)

-- 常量
_M.ACCOUNT_STATE_INIT       = 0          --初始状态
_M.ACCOUNT_STATE_CREATING   = 1          --帐号正在创建角色、等待回调的状态
_M.ACCOUNT_STATE_DESTORYING = 2          --角色正在删除状态
_M.ACCOUNT_STATE_LOGINING   = 3          --帐号正在登录角色、等待回调的状态

--帐号的角色状态
_M.CHARACTER_STATE_NONE       = 0
_M.CHARACTER_STATE_CREATING   = 1
_M.CHARACTER_STATE_CREATED    = 2

-- 初始化
function _M:init(db, model)
	p("Account:init", db, model)

    self.db = db
    self.model = model

	if self:get_dbid() == 0 then
		self.create_time = os.time()

        local db_id = self:write_to_db(db, model)

        self:set_dbid(db_id)
	end

	self.avatar_state = _M.CHARACTER_STATE_NONE

	self.state = _M.ACCOUNT_STATE_INIT

    p("account init end")
	return 0
end

-- 销毁
function _M:on_destory()
	p("Account on_destory")
	-- 删除激活的角色
	local avatar_id = self.active_avatar_id or 0
	if avatar_id > 0 then
		local avatar = manager.entity(avatar_id)
		if avatar then
			-- 删除avatar
			avatar:delete_self()
		end
	end
	-- 保存
	self:write_to_db(self.db, self.model)
end

-- 客户端连接到entity的回调方法
function _M:on_client_get_base()
	p("Account.on_client_get_base")
	-- 更新账号状态

	-- 默认如果有一个角色就自动开始游戏
	local avatar_info = self.avatars[1]
	if avatar_info then
        self:start_game(avatar_info.db_id)

        return
	else
        -- 创建角色
        local _, dbid = self:create_character("boibot", 1, 1)
        p("character dbid = ", dbid)
        if dbid then
            self:start_game(dbid)
        end
    end

end

-- 客户端断开回调方法
function _M:on_client_lost()
	p("Account on_client_lost")

	local avatar_id = self.active_avatar_id or 0

	if avatar_id > 0 then
		local avatar = manager.entity(avatar_id)
		if avatar then
			avatar:delete_all()
		else
			manager.destory(self.id)
		end
	else
		manager.destory(self.id)
	end
end

function _M:on_multilogin()
	-- body
end

return _M
