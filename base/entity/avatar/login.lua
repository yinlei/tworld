-------------------------------------------------------------------------------
-- login.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local manager = require("lib.entity").manager

local global = require("base.core").global

local _M = require (_PACKAGE.."/avatar")

---
function _M:set_space_loader(space_loader)
	self.space_loader = space_loader
end

-- 角色登录到地图
function _M:on_first_login(space_base_service)
	p({"Avatar on_first_login", space_base_service})

	-- 1. 发送仓库数据
    if self.inventory_system then
        self.inventory_system:update_all_to_client()
    end

	-- 2. 创建角色的cell
	self:create_cell(space_base_service)
	p("create_cell end ... ")

	-- 设置空间代理
	self:set_space_loader(space_base_service)
	p("set_space_loader after ... ")

	-- 定时存盘
	--self:register_time_save()
	-- 更新下线时间
	self.offline_time = os.time()
	-- 更新登录时间
	self.login_time = self.offline_time

	-- 其他 ....
    p("Avatar on_first_login end")
end

-- 客户端连接到Entity时回调
function _M:on_client_get_base()
	p("Avatar on_client_get_base")
	local account = manager.entity(self.account_id)

	if account then
		account.avatar_state = 0
	else
		p("Avatar on_client_get_base cannot find account ", self.account_id)
	end

	-- 上线
end

-- 客户端断开到Entity时回调
function _M:on_client_lost_base()
	p("Avatar on_client_lost_base")
	local account = manager.entity(self.account_id)

	if account then
	end

	-- 下线
end

-- 退出游戏
-- flag 标记是直接退出游戏 还是 返回角色界面
function _M:logout(flag)
	p("Avatar logout")
	if self:has_client() then
		self.client.OnLogoutResp(flag)
	end

	local account = manager.entity(self.account_id)
	-- 如果是返回到角色界面
	if account and flag == 0 then
		accoun.avatar_quit_flag = 0
		account.update_avatar_info(self, self.db_id)
		self:give_client_to(accout)
		return
	end

	-- 如果退出游戏就删除角色实体
	self:delete_all()
end