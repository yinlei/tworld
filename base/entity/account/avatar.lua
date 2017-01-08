-------------------------------------------------------------------------------
-- avatar.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local table_insert = table.insert

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local _M = require (_PACKAGE.."/account")

-- 添加角色信息
function _M:add_avatar_info(avatar, db_id)
	DEBUG_MSG("Account add_avatar_info")
	if avatar then
		local avatar_info = {}
		avatar_info.db_id = db_id
		avatar_info.name = avatar.name
		avatar_info.vocation = avatar.vocation
		avatar_info.level = avatar.level

		table_insert(self.avatars, avatar_info)
	end
    DEBUG_MSG("Account add_avatar_info end")
end

-- 更新角色信息
function _M:update_avatar_info(avatar, db_id)
	if not avatar then
		ERROR_MSG("Account update_avatar_info avatar is nil !!!")
		return
	end

	local dbid = db_id or avatar.db_id

	for i, value in ipairs(self.avatars) do
		if value.db_id == dbid then
			value.name = avatar.name
			value.vocation = avatar.vocation
			value.level = avatar.level
			return 0
		end
	end
end

-- 角色信息是否有效
function _M:is_owner_character(char_dbid)
    if char_dbid == 0 then
        return false
    end

    for _, char_info in pairs(self.avatars) do
        if char_info.db_id == char_dbid then
            return true
        end
    end

	return false
end

