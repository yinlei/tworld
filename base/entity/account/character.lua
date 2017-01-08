-------------------------------------------------------------------------------
-- character.lua
-------------------------------------------------------------------------------
local _PACKAGE      = (...):match("^(.+)[%./][^%./]+") or ""

local LOG = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local ERROR = tengine.ERROR_MSG

local p = tengine.p

local EntityManager = require("lib.entity").manager
local store = require("lib.store")

local global = require("base.core").global
local factory = require("base.core").factory

local _M = require (_PACKAGE.."/account")

-- 创建角色的返回值
_M.CREATE_AVATAR_NAME_EXISTS = 1       -- 角色名字已经存在
_M.CREATE_AVATAR_NAME_TOO_SHORT = 2
_M.CREATE_AVATAR_NAME_TOO_LONG = 3
_M.CREATE_AVATAR_NAME_INVALID = 4
_M.CREATE_AVATAR_NAME_BANNED = 5

-- 创建新角色
-- 参数 1.名字 2. 性别 3. 职业
function _M:create_character(name, gender, vocation)
	DEBUG("Account.create_character name = %s, gender = %d, vocation = %d", name, gender, vocation)

	-- 角色名字
	local count = 0
	for _, avatar in ipairs(self.avatars) do
		if avatar.name == name then
            return Account.CREATE_AVATAR_NAME_EXISTS
		end

		if avatar.db_id ~= 0 then
			count = count + 1
		end
	end

	-- TODO
    -- 1. 角色数量
    -- 2. 角色名字是否合法

	local user_manager = global.object("UserManager")
	if not user_manager then
		ERROR("cann't find UserManager!!!")
        return
	end

    --[[
    local ok, ret = user_manager.check_name(name)
    if not ok or ret ~= 0 then
        return Account.CREATE_AVATAR_NAME_EXISTS
    end
    --]]

    -- 获取avatar model
    local model = store.model("avatar")
    if not model then
        ERROR_MSG("cann't get %s model !!!", "avatar")
        return
    end

    local avatar = factory.create_base("Avatar")
    if not avatar then
        ERROR_MSG("factory Avatar failed !!!")
        return
    end

    avatar:create(self, name, gender, vocation)

    --TODO 保存数据
   	local autoid = assert(avatar:write_to_db(self.db, model))
    tengine.p("avatar wirte to db db_id = ", db_id)

    local db_id = tonumber(autoid)
    avatar.db_id = db_id

    self:add_avatar_info(avatar, db_id)
    self.active_avatar_id = avatar.id

    --avatar:init_items_for_avatar(vocation, id)

    -- TODO UserManager add avatar name

    return avatar.id, db_id
end

-- 请求角色列表
function _M:character_info()
    return self.avatars
end

-- 删除角色信息
function _M:delete_character(char_db_id)
	local result = 0
	for k, avatar in pairs(self.avatars) do
		if avatar.db_id == char_db_id then
			table.remove(self.avatars, k)

			result = 0
		end
	end

    -- TODO 删除已经创建的Avatar
    if self.active_avatar_id > 0 and result == 0 then
        local last_avatar = factory.entity(self.active_avatar_id)
        if last_avatar and last_avatar.db_id == char_db_id then
            last_avatar:delete_self()
        end
    end
end

