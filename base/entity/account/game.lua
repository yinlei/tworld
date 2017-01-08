-------------------------------------------------------------------------------
-- game.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local unpack = unpack or table.unpack

local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local EntityManager = require("lib.entity").manager

local global = require("base.core").global
local factory = require("base.core").factory
local key = require("base.core").key

local server = require "server"

local _M = require (_PACKAGE.."/account")

function _M:enter_game(char_id)
    local _key = key.add(self.id, char_id)
    return {_key, server.address()}
end

-- 开始游戏
function _M:start_game(char_db_id)
	DEBUG_MSG("Account start_game char_db_id = %d ", char_db_id)
	-- 一些必要的检查

    -- 是否在创建角色
	if self.avatar_state == Account.CHARACTER_STATE_CREATING then
		return
	end

	if char_db_id <= 0 then
        ERROR_MSG("char_db_id is invalid")
        return
	end

	if not self:is_owner_character(char_db_id) then
        ERROR_MSG("no owner character")
		return
	end

    -- TODO 检测ip和账号是否被禁止
	--[[
	if self:is_ip_forbidden() then
		return
	end

	if self:is_account_forbidden() then
		return
	end
	--]]

	self.active_avatar_id = self.active_avatar_id or 0
    p("active_avatar_id = " .. self.active_avatar_id)

	if self.active_avatar_id > 0 then
		local last_avatar = EntityManager.entity(self.active_avatar_id)
		if last_avatar then
			if char_db_id ~= last_avatar.db_id then
				-- 删除
                last_avatar:delete_self()
			else
				-- 进入场景
                local mapmanager = global.object("MapManager")
                if not mapmanager then
                    ERROR_MSG("cann't get global MapManager !!!")
                    return
                end

                local ok, ret = mapmanager.select_map(104, 0, last_avatar.db_id, last_avatar.name)
                if not ok then
                    ERROR_MSG("mapmanager select_map failed !!!")
                    return
                end

                p("get ret ", ret)

                self:select_map(last_avatar, 104, 1, unpack(ret))

                DEBUG_MSG("start game ok ...")
				return
			end

		end
	end

	-- 载入Avatar
	local function on_avatar_loaded(avatar)
		DEBUG_MSG("on_avatar_loaded ....")

		if avatar then
			self.active_avatar_id = avatar:get_id()

			avatar.account = self:get_id()

			avatar:write_to_db(
				function( ... )
					INFO("Avatar write_to_db end")
				end
			)

			-- 可以进入场景
			p("enter scene !!!", self.service)
			global.call("MapManager", "SelectMapReq", self.service, 10004,
                        0, avatar.db_id, avatar.name)

			-- 更新状态

		else
			if self:has_client() then
				self.client.OnLoginResp(-1)
			end
		end
	end

	-- 如果角色没有创建
	self.avatar_state = Account.CHARACTER_STATE_CREATING

	factory.create_base_from_dbid("Avatar", char_db_id, on_avatar_loaded)

end

-- 选择场景callback
function _M:select_map(avatar, map_id, line_id, space_base_service,
                                 space_cell_service)
  p({"Account select_map", map_id, line_id, space_base_service,
     space_cell_service, dbid, params})

	-- 设置坐标
	avatar.scene_id = map_id
	avatar.imap_id = line_id

	-- 根据地图类型设置起始坐标
	avatar.map_x = 0
	avatar.map_y = 0

	if self.client then

		self.client.on_login(0)

		self:give_client_to(avatar)

		avatar:on_first_login(space_base_service)
	end
end
